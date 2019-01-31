#Ingress controller

### Minikube Ingress addon
If your cluster is running in Minikube you can enable the Ingress controller just executing:
```
$ minikube addons enable ingress
ingress was successfully enabled
```
After a couple of minutes you should be able to see the controller running in the kube-system namespace:
```
$ kubectl get pod -n kube-system -l app.kubernetes.io/name
NAME                                       READY   STATUS    RESTARTS   AGE
default-http-backend-5ff9d456ff-wnpzl      1/1     Running   0          10m
nginx-ingress-controller-7c66d668b-zqbzf   1/1     Running   0          10m

```

### Nginx Ingress
https://github.com/kubernetes/ingress-nginx/blob/master/docs/deploy/index.md

### Kong Ingress
https://github.com/Kong/kubernetes-ingress-controller/tree/master/docs/deployment
```
$ kubectl get pods -n kong
NAME                                       READY     STATUS    RESTARTS   AGE
kong-56c4cc55c9-78srh                      1/1       Running   0          1h
kong-ingress-controller-79f48dd4d7-ql4vw   2/2       Running   0          1h
postgres-0                                 1/1       Running   1          22h
```

### Traefik Ingress
https://docs.traefik.io/user-guide/kubernetes/
```
$ kubectl get pod -n kube-system -l name=traefik-ingress-lb
NAME                                          READY     STATUS    RESTARTS   AGE
traefik-ingress-controller-57b4767f99-g42n2   1/1       Running   0          1m
```

