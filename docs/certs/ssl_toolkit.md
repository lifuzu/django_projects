### Install CloudFlare's SSL ToolKit (cfssl and cfssljson)
https://github.com/cloudflare/cfssl

Start by installing Go if you don't already have it.

Again, if you’re on a Mac, the quickest way to install Go is with Homebrew:
```
$ brew update
$ brew install go --cross-compile-common
# OR
$ brew upgrade go
```
Once installed, create a workspace, configure the GOPATH and add the workspace's bin folder to your system path:
```
$ mkdir $HOME/go
$ export GOPATH=$HOME/go
$ export PATH=$PATH:$GOPATH/bin
```
Next, install the SSL ToolKit:
```
$ go get -u github.com/cloudflare/cfssl/cmd/cfssl
$ go get -u github.com/cloudflare/cfssl/cmd/cfssljson
```

Create a directory called `certs` under `tools` and add the following files and folders:
```
├── certs
│   ├── config
│   │   ├── ca-config.json
│   │   ├── ca-csr.json
│   │   ├── consul-csr.json
│   │   └── vault-csr.json
```
ca-config.json:
```
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "default": {
        "usages": [
          "signing",
          "key encipherment",
          "server auth",
          "client auth"
        ],
        "expiry": "8760h"
      }
    }
  }
}
```
ca-csr.json:
```
{
  "hosts": [
    "cluster.local"
  ],
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
consul-csr:
```
{
  "CN": "server.dc1.cluster.local",
  "hosts": [
    "server.dc1.cluster.local",
    "127.0.0.1"
  ],
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
vault-csr.json:
```
{
  "hosts": [
    "vault",
    "127.0.0.1"
  ],
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

Create a Certificate Authority:
```
$ cfssl gencert -initca tools/certs/config/ca-csr.json | cfssljson -bare tools/certs/ca
2019/01/29 21:24:59 [INFO] generating a new CA key and certificate from CSR
2019/01/29 21:24:59 [INFO] generate received request
2019/01/29 21:24:59 [INFO] received CSR
2019/01/29 21:24:59 [INFO] generating key: rsa-2048
2019/01/29 21:24:59 [INFO] encoded CSR
2019/01/29 21:24:59 [INFO] signed certificate with serial number 622428701818013839835024179113463478720424511665
```

Then, create a private key and a TLS certificate for Consul:
```
$ cfssl gencert \
    -ca=tools/certs/ca.pem \
    -ca-key=tools/certs/ca-key.pem \
    -config=tools/certs/config/ca-config.json \
    -profile=default \
    tools/certs/config/consul-csr.json | cfssljson -bare tools/certs/consul
2019/01/29 21:26:20 [INFO] generate received request
2019/01/29 21:26:20 [INFO] received CSR
2019/01/29 21:26:20 [INFO] generating key: rsa-2048
2019/01/29 21:26:20 [INFO] encoded CSR
2019/01/29 21:26:20 [INFO] signed certificate with serial number 106196641239750416687156180492689189852958870445
```
Do the same for Vault:
```
$ cfssl gencert \
    -ca=tools/certs/ca.pem \
    -ca-key=tools/certs/ca-key.pem \
    -config=tools/certs/config/ca-config.json \
    -profile=default \
    tools/certs/config/vault-csr.json | cfssljson -bare tools/certs/vault
2019/01/29 21:27:25 [INFO] generate received request
2019/01/29 21:27:25 [INFO] received CSR
2019/01/29 21:27:25 [INFO] generating key: rsa-2048
2019/01/29 21:27:26 [INFO] encoded CSR
2019/01/29 21:27:26 [INFO] signed certificate with serial number 473052007023399167394143586921815148264579234061
```

From the output of CloudFlare's SSL ToolKit:
```
--tlscert=/etc/docker/server.pem -- TLS certificate file
--tlskey=/etc/docker/server-key.pem -- TLS key file
```
Learning from: https://github.com/kelseyhightower/docker-kubernetes-tls-guide
