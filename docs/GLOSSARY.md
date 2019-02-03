
## RBAC
Role-based access control (RBAC)
https://kubernetes.io/docs/reference/access-authn-authz/rbac/

## TLS
Transport-Level Security

## SNI
Server Name Indication (SNI) is an extension to the TLS computer networking protocol by which a client indicates which hostname it is attempting to connect to at the start of the handshaking process. This allows a server to present multiple certificates on the same IP address and TCP port number and hence allows multiple secure (HTTPS) websites (or any other service over TLS) to be served by the same IP address without requiring all those sites to use the same certificate. It is the conceptual equivalent to HTTP/1.1 name-based virtual hosting, but for HTTPS.

## Node
A single virtual or physical machine in a Kubernetes cluster.

## Cluster
A group of nodes firewalled from the internet, that are the primary compute resources managed by Kubernetes.

## Edge router
A router that enforces the firewall policy for your cluster. This could be a gateway managed by a cloud provider or a physical piece of hardware.

## Cluster network
A set of links, logical or physical, that facilitate communication within a cluster according to the Kubernetes networking model.

## Service
A Kubernetes Service that identifies a set of pods using label selectors. Unless mentioned otherwise, Services are assumed to have virtual IPs only routable within the cluster network.

## Ingress
Ingress exposes HTTP and HTTPS routes from outside the cluster to services within the cluster. Traffic routing is controlled by rules defined on the ingress resource.
An ingress can be configured to give services externally-reachable URLs, load balance traffic, terminate SSL, and offer name based virtual hosting.
An ingress does not expose arbitrary ports or protocols. Exposing services other than HTTP and HTTPS to the internet typically uses a service of type Service.Type=NodePort or Service.Type=LoadBalancer.
https://kubernetes.io/docs/concepts/services-networking/ingress

## Ingress controller
An ingress controller is responsible for fulfilling the ingress, usually with a loadbalancer, though it may also configure your edge router or additional frontends to help handle the traffic.
In order for the ingress resource to work, the cluster must have an ingress controller running. This is unlike other types of controllers, which run as part of the kube-controller-manager binary, and are typically started automatically with a cluster.