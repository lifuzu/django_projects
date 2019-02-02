
### Install Minikube
https://testdriven.io/blog/running-vault-and-consul-on-kubernetes/

Follow the official quickstart guide to get Minikube installed along with:

A Hypervisor (like VirtualBox or HyperKit) to manage virtual machines
Kubectl to deploy and manage apps on Kubernetes
If you’re on a Mac, we recommend installing Kubectl, Virtualbox, and Minikube with Homebrew:
```
$ brew update
$ brew install kubectl
$ brew cask install virtualbox
$ brew cask install minikube
```

Then, start the cluster:
```
$ minikube start  # or minikube start --vm-driver=hyperkit
```

Pull up the Minikube dashboard (Web UI)
```
$ minikube dashboard
```
the Web UI here:
http://127.0.0.1:49327/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/
OR
```
$ kubectl proxy --port=8123
```
which will pull up the dashboard with the Web UI here:
http://localhost:8123/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/

Stop the minikube cluster:
```
$ minikube stop
Stopping local Kubernetes cluster...
Machine stopped.
```

Minikube sets this context to default automatically, but if you need to switch back to it in the future, run:
```
$ kubectl config use-context minikube
```
or pass the context on each command like this:
```
$ kubectl get pods --context=minikube
```

Status
```
$ minikube status
```

List addons:
```
$ minikube addons list
```

Enable one addon:
```
$ minikube addons enable ingress
```

Check pods in minikube:
```
$ kubectl get pod -n kube-system
```

Other misc commands:
```
$ kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080
deployment "hello-minikube" created
$ kubectl expose deployment hello-minikube --type=NodePort
service "hello-minikube" exposed

# We have now launched an echoserver pod but we have to wait until the pod is up before curling/accessing it
# via the exposed service.
# To check whether the pod is up and running we can use the following:
$ kubectl get pod
NAME                              READY     STATUS              RESTARTS   AGE
hello-minikube-3383150820-vctvh   1/1       ContainerCreating   0          3s
# We can see that the pod is still being created from the ContainerCreating status
$ kubectl get pod
NAME                              READY     STATUS    RESTARTS   AGE
hello-minikube-3383150820-vctvh   1/1       Running   0          13s
# We can see that the pod is now Running and we will now be able to curl it:
$ curl $(minikube service hello-minikube --url)
CLIENT VALUES:
client_address=192.168.99.1
command=GET
real path=/
...
$ kubectl delete service hello-minikube
service "hello-minikube" deleted
$ kubectl delete deployment hello-minikube
deployment "hello-minikube" deleted
```

### Enable RBAC (not verify yet)
https://gist.github.com/F21/08bfc2e3592bed1e931ec40b8d2ab6f5
```
$ minikube start --extra-config=apiserver.authorization-mode=RBAC
$ kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
```

### References
https://kubernetes.io/docs/setup/minikube/
https://github.com/kubernetes/minikube#quickstart
https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/

RBAC:
https://github.com/kubernetes/minikube/issues/1734#issue-245035445
https://github.com/kubernetes/minikube/issues/1722
https://github.com/kubernetes/minikube/issues/2510