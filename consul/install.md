### Install Consul client
https://testdriven.io/blog/running-vault-and-consul-on-kubernetes/

```
$ brew install consul
# OR
$ brew upgrade consul
```

Then generate a key and store it in an environment variable:
```
$ export GOSSIP_ENCRYPTION_KEY=$(consul keygen)
```

Store the key along with the TLS certificates in a Secret:
```
$ kubectl create secret generic consul \
  --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
  --from-file=tools/certs/ca.pem \
  --from-file=tools/certs/consul.pem \
  --from-file=tools/certs/consul-key.pem
secret/consul created
```
Verify:
```
$ kubectl describe secrets consul
Name:         consul
Namespace:    default
Labels:       <none>
Annotations:  <none>

Type:  Opaque

Data
====
gossip-encryption-key:  24 bytes
ca.pem:                 1168 bytes
consul-key.pem:         1679 bytes
consul.pem:             1359 bytes
```

Config with a new file to "tools/provision/consul" called config.json:
```
{
  "ca_file": "/etc/tls/ca.pem",
  "cert_file": "/etc/tls/consul.pem",
  "key_file": "/etc/tls/consul-key.pem",
  "verify_incoming": true,
  "verify_outgoing": true,
  "verify_server_hostname": true,
  "ports": {
    "https": 8443
  }
}
```
By setting verify_incoming, verify_outgoing and verify_server_hostname to true all RPC calls must be encrypted. (review the RPC Encryption with TLS guide from the Consul docs for more info on these options.)
https://www.consul.io/docs/agent/encryption.html#rpc-encryption-with-tls

Save this config in a ConfigMap:
```
$ kubectl create configmap consul --from-file=tools/provision/consul/config.json
configmap/consul created
$ kubectl describe configmap consul
Name:         consul
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
config.json:
----
{
  "ca_file": "/etc/tls/ca.pem",
  "cert_file": "/etc/tls/consul.pem",
  "key_file": "/etc/tls/consul-key.pem",
  "verify_incoming": true,
  "verify_outgoing": true,
  "verify_server_hostname": true,
  "ports": {
    "https": 8443
  }
}

Events:  <none>

```
Create the Service:
```
$ kubectl create -f tools/provision/consul/service.yaml
service/consul created
$ kubectl get service consul
NAME     TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                                                                            AGE
consul   ClusterIP   None         <none>        8500/TCP,8443/TCP,8400/TCP,8301/TCP,8301/UDP,8302/TCP,8302/UDP,8300/TCP,8600/TCP   12s
```
(Be sure to create the Service before the StatefulSet since the Pods created by the StatefulSet will immediately start doing DNS lookups to find other members.)

Deploy a three-node Consul cluster:
```
$ kubectl create -f tools/provision/consul/statefulset.yaml
statefulset.apps/consul created
```

Verify that the Pods are up and running:
```
$ kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
consul-0   1/1     Running   0          48s
consul-1   1/1     Running   0          36s
consul-2   1/1     Running   0          34s
```

Take a look at the logs from each of the Pods to ensure that one of them has been chosen as the leader:
```
$ kubectl logs consul-0
$ kubectl logs consul-1
$ kubectl logs consul-2
```

Sample logs:
```
2019/01/30 05:42:06 [INFO] consul: New leader elected: consul-0
2019/01/30 05:42:06 [WARN] raft: AppendEntries to {Voter 1df6609b-e255-fea5-ecb0-653af285d27d 172.17.0.7:8300} rejected, sending older logs (next: 1)
2019/01/30 05:42:06 [INFO] raft: pipelining replication to peer {Voter 1df6609b-e255-fea5-ecb0-653af285d27d 172.17.0.7:8300}
2019/01/30 05:42:06 [INFO] raft: pipelining replication to peer {Voter 3c70f44d-9dc4-a5e7-a2b2-c99a677e21e7 172.17.0.6:8300}
2019/01/30 05:42:06 [INFO] consul: member 'consul-0' joined, marking health alive
2019/01/30 05:42:06 [INFO] consul: member 'consul-1' joined, marking health alive
2019/01/30 05:42:06 [INFO] consul: member 'consul-2' joined, marking health alive
2019/01/30 05:42:09 [INFO] agent: Synced node info
```

Forward the port to the local machine:
```
$ kubectl port-forward consul-1 8500:8500
```

Then, in a new terminal window, ensure that all members are alive:
```
$ consul members
Node      Address          Status  Type    Build  Protocol  DC   Segment
consul-0  172.17.0.5:8301  alive   server  1.4.0  2         dc1  <all>
consul-1  172.17.0.6:8301  alive   server  1.4.0  2         dc1  <all>
consul-2  172.17.0.7:8301  alive   server  1.4.0  2         dc1  <all>
```
Finally, you should be able to access the web interface at http://localhost:8500.


Then, clean up:
```
$ kubectl delete \
    -f tools/provision/consul/service.yaml \
    -f tools/provision/consul/statefulset.yaml
```

List Consul pods:
```
$ kubectl get pods -l app=consul
NAME                     READY   STATUS    RESTARTS   AGE
...
```

Delete Vault pods:
```
$ kubectl delete pods -l app=consul
```
