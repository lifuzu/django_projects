### Install
https://kubeless.io/docs/quick-start/
```
$ export RELEASE=$(curl -s https://api.github.com/repos/kubeless/kubeless/releases/latest | grep tag_name | cut -d '"' -f 4)
$ kubectl create ns kubeless
namespace/kubeless created
$ kubectl create -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml
configmap/kubeless-config created
deployment.apps/kubeless-controller-manager created
serviceaccount/controller-acct created
clusterrole.rbac.authorization.k8s.io/kubeless-controller-deployer created
clusterrolebinding.rbac.authorization.k8s.io/kubeless-controller-deployer created
customresourcedefinition.apiextensions.k8s.io/functions.kubeless.io created
customresourcedefinition.apiextensions.k8s.io/httptriggers.kubeless.io created
customresourcedefinition.apiextensions.k8s.io/cronjobtriggers.kubeless.io created
```
```
$ kubectl get pods -n kubeless
NAME                                           READY   STATUS    RESTARTS   AGE
kubeless-controller-manager-7c7bcb8db4-fxzb8   3/3     Running   0          46s

$ kubectl get deployment -n kubeless
NAME                          READY   UP-TO-DATE   AVAILABLE   AGE
kubeless-controller-manager   1/1     1            1           55s

$ kubectl get customresourcedefinition
NAME                          CREATED AT
cronjobtriggers.kubeless.io   2019-01-31T05:01:41Z
functions.kubeless.io         2019-01-31T05:01:41Z
httptriggers.kubeless.io      2019-01-31T05:01:41Z
```
kubeless-$RELEASE.yaml is used for RBAC Kubernetes cluster.
kubeless-non-rbac-$RELEASE.yaml is used for non-RBAC Kubernetes cluster.
kubeless-openshift-$RELEASE.yaml is used to deploy Kubeless to OpenShift (1.5+).

### Installing kubeless CLI:
```
export OS=$(uname -s| tr '[:upper:]' '[:lower:]')
curl -OL https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless_$OS-amd64.zip && \
  unzip kubeless_$OS-amd64.zip && \
  sudo mv bundles/kubeless_$OS-amd64/kubeless /usr/local/bin/
```

### Create a hello world function here: tools/kubeless/helloworld/hello.py
```
def hello(event, context):
  print("event: {}".format(event))
  return event['data']
```

### Deploy the function: (Pause here)
```
$ kubeless function deploy hello --runtime python3.7 \
                                --from-file tools/kubeless/helloworld/hello.py \
                                --handler hello.hello
INFO[0000] Deploying function...
INFO[0000] Function hello submitted for deployment
INFO[0000] Check the deployment status executing 'kubeless function ls hello'
```

### Verify the function custom resource created:
```
$ kubectl get functions
NAME         AGE
hello        1h

$ kubeless function ls
NAME    NAMESPACE   HANDLER     RUNTIME     DEPENDENCIES    STATUS
hello   default     hello.hello python3.7                   1/1 READY
```

### Call the function with:
```
$ kubeless function call hello --data 'Hello world!'
Hello world!
```

###  Curl directly with kubectl proxyusing an apiserver proxy URL.
For example:
```
$ kubectl proxy -p 8080 &

$ curl -L --data '{"Another": "Echo"}' \
  --header "Content-Type:application/json" \
  localhost:8080/api/v1/namespaces/default/services/hello:http-function-port/proxy/

{"Another": "Echo"}
```
### Check the log when need to debug
```
$ kubectl logs -n kubeless -l kubeless=controller -c kubeless-function-controller
time="2019-01-31T04:42:09Z" level=info msg="Running Kubeless controller manager version: v1.0.1"
time="2019-01-31T04:42:09Z" level=fatal msg="Unable to read the configmap: Error while fetching config location: customresourcedefinitions.apiextensions.k8s.io \"functions.kubeless.io\" is forbidden: User \"system:serviceaccount:kubeless:controller-acct\" cannot get resource \"customresourcedefinitions\" in API group \"apiextensions.k8s.io\" at the cluster scope"
```

### Delete namespace
```
$ kubectl delete ns kubeless
namespace "kubeless" deleted
```

### Delete the function and uninstall Kubeless:
```
$ kubeless function delete hello

$ kubeless function ls
NAME        NAMESPACE   HANDLER     RUNTIME     DEPENDENCIES    STATUS

$ kubectl delete -f https://github.com/kubeless/kubeless/releases/download/$RELEASE/kubeless-$RELEASE.yaml
```