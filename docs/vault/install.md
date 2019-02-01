### Install

Store the Vault TLS certificates that we created (docs/certs/ssl_toolkit.md) in a Secret:
```
$ kubectl create secret generic vault \
    --from-file=tools/certs/ca.pem \
    --from-file=tools/certs/vault.pem \
    --from-file=tools/certs/vault-key.pem
secret/vault created
$ kubectl describe secrets vault
Name:         vault
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
ca.pem:         1168 bytes
vault-key.pem:  1675 bytes
vault.pem:      1241 bytes

```

ConfigMap
Add a new file for the Vault config called tools/provision/vault/config.json:
```
{
  "listener": {
    "tcp":{
      "address": "127.0.0.1:8200",
      "tls_disable": 0,
      "tls_cert_file": "/etc/tls/vault.pem",
      "tls_key_file": "/etc/tls/vault-key.pem"
    }
  },
  "storage": {
    "consul": {
      "address": "consul:8500",
      "path": "vault/",
      "disable_registration": "true",
      "ha_enabled": "true"
    }
  },
  "ui": true
}
```
Here, we configured Vault to use the Consul backend (which supports high availability), defined the TCP listener for Vault, enabled TLS, added the paths to the TLS certificate and the private key, and enabled the Vault UI. Review the docs for more info on configuring Vault.
https://www.vaultproject.io/docs/configuration/index.html

Save this config in a ConfigMap:
```
$ kubectl create configmap vault --from-file=tools/provision/vault/config.json
configmap/vault created
$ kubectl describe configmap vault
Name:         vault
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
config.json:
----
{
  "listener": {
    "tcp":{
      "address": "127.0.0.1:8200",
      "tls_disable": 0,
      "tls_cert_file": "/etc/tls/vault.pem",
      "tls_key_file": "/etc/tls/vault-key.pem"
    }
  },
  "storage": {
    "consul": {
      "address": "consul:8500",
      "path": "vault/",
      "disable_registration": "true",
      "ha_enabled": "true"
    }
  },
  "ui": true
}

Events:  <none>
```

Create service with tools/provision/vault/service.yaml:
```
$ kubectl create -f tools/provision/vault/service.yaml
service/vault created
$ kubectl get service vault
NAME    TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
vault   ClusterIP   10.107.153.152   <none>        8200/TCP   9s
```

Create deployment with tools/provision/vault/deployment.yaml:
```
$ kubectl create -f tools/provision/vault/deployment.yaml
deployment.extensions/vault created
```

To test, grab the Pod name and then forward the port:
```
$ kubectl get pods
NAME                     READY   STATUS    RESTARTS   AGE
consul-0                 1/1     Running   0          23m
consul-1                 1/1     Running   0          23m
consul-2                 1/1     Running   0          23m
vault-69c7d8bcdd-l4hgl   2/2     Running   0          45s

$ kubectl port-forward vault-69c7d8bcdd-l4hgl 8200:8200
```
Make sure you can view the UI at https://localhost:8200.


Quick Test
With port forwarding still on, in a new terminal window, navigate to the project directory and set the VAULT_ADDR and VAULT_CACERT environment variables:
```
$ export VAULT_ADDR=https://127.0.0.1:8200
$ export VAULT_CACERT="tools/certs/ca.pem"
```

Install the Vault client locally, if you don't already have it, and then init Vault with a single key:
```
$ vault operator init -key-shares=1 -key-threshold=1
Unseal Key 1: hDV0E5GYXG2+eUaLdzQDzkmsmTGecI/z9qsmb7ugx84=

Initial Root Token: 3xSO00i9BJqr7yk2St2EnuLU

Vault initialized with 1 key shares and a key threshold of 1. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 1 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 1 key to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
```

Unseal:
```
$ vault operator unseal
Unseal Key (will be hidden): <input the previous command output - Unseal Key 1 >
Key                    Value
---                    -----
Seal Type              shamir
Initialized            true
Sealed                 false
Total Shares           1
Threshold              1
Version                0.11.5
Cluster Name           vault-cluster-bb57c8d5
Cluster ID             ae1e27f6-45b3-b5a0-3062-4752ce5dc18b
HA Enabled             true
HA Cluster             n/a
HA Mode                standby
Active Node Address    <none>
```

Authenticate with the root token:
```
$ vault login
Token (will be hidden):
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                3xSO00i9BJqr7yk2St2EnuLU
token_accessor       jLEvH9bZdYKKM4nPfcyoLo78
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```

Create a new secret:
```
$ vault kv put secret/precious foo=bar
Success! Data written to: secret/precious
```
Read:
```
$ vault kv get secret/precious

=== Data ===
Key    Value
---    -----
foo    bar
```
Check the status:
```
$ vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    1
Threshold       1
Version         0.11.5
Cluster Name    vault-cluster-bb57c8d5
Cluster ID      ae1e27f6-45b3-b5a0-3062-4752ce5dc18b
HA Enabled      true
HA Cluster      https://127.0.0.1:8201
HA Mode         active
```
