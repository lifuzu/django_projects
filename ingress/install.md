#Ingress controller
https://kubernetes.io/docs/concepts/services-networking/ingress

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

### HAProxy Ingress
https://www.haproxy.com/blog/haproxy_ingress_controller_for_kubernetes/

### Ambassador/Envoy Ingress
[Ambassador](../ambassador/README.md)

## Ingress controllers
- Kubernetes as a project currently supports and maintains GCE and nginx controllers.
- Contour is an Envoy based ingress controller provided and supported by Heptio.
- Citrix provides an Ingress Controller for its hardware (MPX), virtualized (VPX) and free containerized (CPX) ADC for baremetal and cloud deployments.
- F5 Networks provides support and maintenance for the F5 BIG-IP Controller for Kubernetes.
- Gloo is an open-source ingress controller based on Envoy which offers API Gateway functionality with enterprise support from solo.io.
- HAProxy based ingress controller jcmoraisjr/haproxy-ingress which is mentioned on the blog post HAProxy Ingress Controller for Kubernetes. HAProxy Technologies offers support and maintenance for HAProxy Enterprise and the ingress controller jcmoraisjr/haproxy-ingress.
- Istio based ingress controller Control Ingress Traffic.
- Kong offers community or commercial support and maintenance for the Kong Ingress Controller for Kubernetes.
- NGINX, Inc. offers support and maintenance for the NGINX Ingress Controller for Kubernetes.
- Traefik is a fully featured ingress controller (Let’s Encrypt, secrets, http2, websocket), and it also comes with commercial support by Containous.

## Multiple Ingress controllers
https://github.com/kubernetes/ingress-nginx/blob/master/docs/user-guide/multiple-ingress.md