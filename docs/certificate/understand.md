TLS - Transport-Level Security

## Automatically generated using Let's Encrypt and cert-manager
https://cert-manager.readthedocs.io/en/latest/tutorials/quick-start/index.html

When you have running cert-manager, you can deploy function and create an HTTP trigger with flag --enableTLSAcme enabled as below:
```
$ kubeless trigger http create get-python --function-name get-python --path get-python --enableTLSAcme
```
Running the above command, Kubeless will automatically create a ingress object with annotation kubernetes.io/tls-acme: 'true' set which will be used by cert-manager to configure the service certificate.

## Self-signed certificate {#self-signed}
Via command `openssl`:
```
$ openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tools/certs/kubeless.key -out tools/certs/kubeless.crt -subj "/CN=rili.local.com"
Generating a 2048 bit RSA private key
..........................................................................................+++
........................................+++
writing new private key to 'tools/certs/kubeless.key'
-----

$ kubectl create secret tls kubeless-secret --key tools/certs/kubeless.key --cert tools/certs/kubeless.crt
secret/kubeless-secret created
```

Via CloudFlare's SSL ToolKit:
Reference: docs/certs/ssl_toolkit.md

Create a kubeless-csr.json file under `tools/certs/config`:
```
├── certs
│   ├── config
│   │   ├── ca-config.json
│   │   ├── ca-csr.json
│   │   ├── consul-csr.json
│   │   ├── vault-csr.json
|   |   └── kubeless-csr.json
```
kubeless-csr.json
with the following content:
```
{
  "CN": "rili.local.com",
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "US",
      "ST": "Colorado",
      "L": "Denver"
    }
  ]
}
```
Then, create a private key and a TLS certificate for Kubeless:
```
$ cfssl gencert \
    -ca=tools/certs/ca.pem \
    -ca-key=tools/certs/ca-key.pem \
    -config=tools/certs/config/ca-config.json \
    -profile=default \
    tools/certs/config/kubeless-csr.json | cfssljson -bare tools/certs/kubeless
2019/01/31 09:15:40 [INFO] generate received request
2019/01/31 09:15:40 [INFO] received CSR
2019/01/31 09:15:40 [INFO] generating key: rsa-2048
2019/01/31 09:15:40 [INFO] encoded CSR
2019/01/31 09:15:40 [INFO] signed certificate with serial number 244614306373872034666377206896126913608658883318
2019/01/31 09:15:40 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
```
Store the TLS certificates in a Secret:
```
$ kubectl create secret tls kubeless-another-secret \
    --key tools/certs/kubeless-key.pem --cert tools/certs/kubeless.pem
secret/kubeless-another-secret created
```


## Provided by a certificate issuer
TODO:


## Use an existing/created certificate to setup TLS for the HTTP trigger, there by securing functions:
```
$ kubeless trigger http create hello --function-name hello --path echo --hostname rili.local.com --tls-secret kubeless-secret
# OR
$ kubeless trigger http create hello --function-name hello --path echo --hostname rili.local.com --tls-secret kubeless-another-secret
INFO[0000] HTTP trigger hello created in namespace default successfully!
```
If the trigger exists (`Error: httptriggers.kubeless.io "hello" already exists `), remove it at first:
```
$ kubeless trigger http delete hello
INFO[0000] HTTP trigger hello deleted from namespace default successfully!
```

If running on Minikube, need to config hosts with Minikube IP address
```
$ echo "$(minikube ip) rili.local.com" | sudo tee -a /etc/hosts
```
Once the Ingress rule has been deployed you can verify that the function is accessible trough HTTPS:
```
$ kubectl get ingress
NAME    HOSTS            ADDRESS     PORTS     AGE
hello   rili.local.com   10.0.2.15   80, 443   78s

$ curl --data '{"Another": "Echo"}' -k https://rili.local.com/echo
{"Another": "Echo"}
```

### Display which secret using:
```
echo | openssl s_client -showcerts -servername rili.local.com -connect rili.local.com:443 2>/dev/null | openssl x509 -inform pem -noout -text
```


### File extensions can be (very) loosely seen as a type system.

 - .pem stands for PEM, Privacy Enhanced Mail; it simply indicates a base64 encoding with header and footer lines. Mail traditionally only handles text, not binary which most cryptographic data is, so some kind of encoding is required to make the contents part of a mail message itself (rather than an encoded attachment). The contents of the PEM are detailed in the header and footer line - .pem itself doesn't specify a data type - just like .xml and .html do not specify the contents of a file, they just specify a specific encoding;
 - .key can be any kind of key, but usually it is the private key - OpenSSL can wrap private keys for all algorithms (RSA, DSA, EC) in a generic and standard PKCS#8 structure, but it also supports a separate 'legacy' structure for each algorithm, and both are still widely used even though the documentation has marked PKCS#8 as superior for almost 20 years; both can be stored as DER (binary) or PEM encoded, and both PEM and PKCS#8 DER can protect the key with password-based encryption or be left unencrypted;
 - .csr stands for Certificate Signing Request, it contains information such as the public key and common name required by a Certificate Authority to create and sign a certificate for the requester, the encoding could be PEM or DER (which is a binary encoding of an ASN.1 specified structure);
 - .crt stands simply for certificate, usually an X509v3 certificate, again the encoding could be PEM or DER; a certificate contains the public key, but it contains much more information (most importantly the signature by the Certificate Authority over the data and public key, of course).

Beware that not everyone may use the same extensions - there is no official register or anything like that. You're probably better off using the POSIX file command line utility first.

https://crypto.stackexchange.com/questions/43697/what-is-the-difference-between-pem-csr-key-and-crt