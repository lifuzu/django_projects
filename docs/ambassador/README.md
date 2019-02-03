
## To deploy Ambassador in your default namespace, first you need to check if Kubernetes has RBAC enabled:
```
$ kubectl cluster-info dump --namespace kube-system | grep authorization-mode
                            "--authorization-mode=Node,RBAC",
```
If you see something like --authorization-mode=Node,RBAC in the output, then RBAC is enabled.

If RBAC is enabled:
```
$ curl -s https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml -o tools/provision/ambassador/rbac.yaml
$ kubectl apply -f tools/provision/ambassador/rbac.yaml
service/ambassador-admin created
clusterrole.rbac.authorization.k8s.io/ambassador created
serviceaccount/ambassador created
clusterrolebinding.rbac.authorization.k8s.io/ambassador created
deployment.extensions/ambassador created
```
Without RBAC, you can use:
```
$ curl -s https://www.getambassador.io/yaml/ambassador/ambassador-no-rbac.yaml -o tools/provision/ambassador/no-rbac.yaml
kubectl apply -f tools/provision/ambassador/no-rbac.yaml
...
```

## Defining the Ambassador Service by creating the following YAML and put it in a file called `tools/provision/ambassador/service.yaml`.
```
---
apiVersion: v1
kind: Service
metadata:
  name: ambassador
spec:
  type: NodePort
  externalTrafficPolicy: Local
  ports:
   - port: 80
  selector:
    service: ambassador
```
Then, deploy this service
```
$ kubectl apply -f tools/provision/ambassador/service.yaml
service/ambassador created
```
The YAML above creates a Kubernetes service for Ambassador of type LoadBalancer, and configures the externalTrafficPolicy to propagate the original source IP of the client. All HTTP traffic will be evaluated against the routing rules you create.

## Creating a route
Create the following YAML and put it in a file called tools/deployment/k8s/route/httpbin.yaml:
```
---
apiVersion: v1
kind: Service
metadata:
  name: httpbin
  annotations:
    getambassador.io/config: |
      ---
      apiVersion: ambassador/v0
      kind:  Mapping
      name:  httpbin_mapping
      prefix: /httpbin/
      service: httpbin.org:80
      host_rewrite: httpbin.org
spec:
  ports:
  - name: httpbin
    port: 80
```
Then, apply it to the Kubernetes with kubectl:
```
$ kubectl apply -f tools/deployment/k8s/route/httpbin.yaml
service/httpbin created
```
When the service is deployed, Ambassador will notice the `getambassador.io/config` annotation on the service, and use the `Mapping` contained in it to configure the route. (Note that Ambassador only looks at annotations on Kubernetes Services.)

In this case, the mapping creates a route that will route traffic from the `/httpbin/` endpoint to the public `httpbin.org` service. Note that we are using the `host_rewrite` attribute for the `httpbin_mapping` — this forces the HTTP Host header, and is often a good idea when mapping to external services. Ambassador supports many different configuration options.
https://www.getambassador.io/reference/configuration/

## Testing the Mapping
We'll need the external IP for Ambassador (it might take some time for this to be available):
```
$ kubectl get svc -o wide ambassador
```
Eventually, this should give you something like:
```
NAME         CLUSTER-IP      EXTERNAL-IP     PORT(S)        AGE
ambassador   10.11.12.13     35.36.37.38     80:31656/TCP   1m
```
You should now be able to use curl to httpbin (don't forget the trailing /):
```
$ curl 35.36.37.38/httpbin/
```
or on minikube:
```
$ minikube service list
|-------------|----------------------|-----------------------------|
|  NAMESPACE  |         NAME         |             URL             |
|-------------|----------------------|-----------------------------|
| default     | ambassador           | http://192.168.99.105:31696 |
| default     | ambassador-admin     | http://192.168.99.105:32023 |
| default     | httpbin              | No node port                |
...
$ curl http://192.168.99.105:31696/httpbin/
```

## Adding a Service route simply by deploying it with an appropriate Ambassador annotation
For example, we can deploy the QoTM service locally in this cluster, and automatically map it through Ambassador by creating `tools/deployment/k8s/services/qotm.yaml`, then applying it with:
```
$ kubectl apply -f tools/deployment/k8s/services/qotm.yaml
service/qotm created
deployment.extensions/qotm created
```
A few seconds after the QoTM service is running, Ambassador should be configured for it. Try it with
```
$ curl http://192.168.99.105:31696/qotm/
```

##  The Diagnostics Service in Kubernetes
Ambassador includes an integrated diagnostics service to help with troubleshooting. By default, this is not exposed to the Internet. To view it, we'll need to get the name of one of the Ambassador pods:
```
$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
ambassador-5bf995dd7f-bjbfd   1/1     Running   2          10h
ambassador-5bf995dd7f-tz7fj   1/1     Running   2          10h
ambassador-5bf995dd7f-x8prv   1/1     Running   2          10h
```
Forwarding local port 8877 to one of the pods:
```
$ kubectl port-forward ambassador-5bf995dd7f-bjbfd 8877
```
will then let us view the diagnostics at `http://localhost:8877/ambassador/v0/diag/`.
