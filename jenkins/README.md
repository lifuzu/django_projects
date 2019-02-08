
### Create Jenkins Dockerfile at `tools/applications/jenkins/Dockerfile`

### Create Jenkins plugins file at `tools/applications/jenkins/plugins.txt`

### Build the Jenkins image
```
$ docker build -t 127.0.0.1:30400/jenkins:latest -f tools/applications/jenkins/Dockerfile tools/applications/jenkins
...
Successfully built 0681f585302e
Successfully tagged 127.0.0.1:30400/jenkins:latest
```

### Push the Jenkins image to cluster registry (with socat proxy)
# Run the socat proxy container (Refer to socat/README.md)
```
$ docker push 127.0.0.1:30400/jenkins:latest
```

### Create Jenkins Kubernetes manifest at `tools/provision/manifests/jenkins.yaml`

### Deploy Jenkins in K8s cluster
```
$ kubectl apply -f tools/provision/manifests/jenkins.yaml
persistentvolume/jenkins created
persistentvolumeclaim/jenkins-claim created
serviceaccount/jenkins created
clusterrolebinding.rbac.authorization.k8s.io/Jenkins-cluster-admin created
configmap/kubectl-jenkins-context created
service/jenkins created
deployment.extensions/jenkins created

$ kubectl rollout status deployment/jenkins
Waiting for deployment "jenkins" rollout to finish: 0 of 1 updated replicas are available...
deployment "jenkins" successfully rolled out
```

### Inspect all the pods that are running. You’ll see a pod for Jenkins now.
```
$ kubectl get pods
NAME                          READY   STATUS    RESTARTS   AGE
...
jenkins-f9ffd4b8b-6pnb2       1/1     Running   0          4m24s
...
```

### Open the Jenkins UI in a web browser.
```
$ minikube service jenkins
```

### Display the Jenkins admin password with the following command, and right-click to copy it.
```
$ kubectl exec -it `kubectl get pods --selector=app=jenkins --output=jsonpath={.items..metadata.name}` cat /var/jenkins_home/secrets/initialAdminPassword
...
c3727421d8044290902bca000bed7b22
...
```

### Switch back to the Jenkins UI. Paste the Jenkins admin password in the box and click Continue. Click `Install suggested plugins`. Plugins have actually been pre-downloaded during the Jenkins image build, so this step should finish fairly quickly.

### Create an admin user and credentials, and click `Save and Continue`. (Make sure to remember these credentials as you will need them for repeated logins.)
```
rili
rili@Jenkins
Richard Li
lifuzu+jenkins@gmail
```

### On the Instance Configuration page, click Save and Finish. On the next page, click Restart (if it appears to hang for some time on restarting, you may have to refresh the browser window). Login to Jenkins.

### Before we create a pipeline, we first need to provision the Kubernetes Continuous Deploy plugin with a kubeconfig file that will allow access to our Kubernetes cluster. In Jenkins on the left, click on `Credentials`, select the `Jenkins` store, then `Global credentials (unrestricted)`, and `Add Credentials` on the left menu

### The following values must be entered precisely as indicated:

Kind: `Kubernetes configuration (kubeconfig)`

ID: `app_kubeconfig`

Kubeconfig: `From a file on the Jenkins master`

File: `/var/jenkins_home/.kube/config`

Finally click `Ok`.

### We now want to create a new `pipeline` for use with our `Hello` app. Back on Jenkins Home, on the left, click `New Item`.

### Enter the item name as `Hello Pipeline`, select `Pipeline`, and click `OK`.

### Under the Pipeline section at the bottom, change the Definition to be `Pipeline script from SCM`.

### Change the SCM to Git. Change the Repository URL to be the URL of your forked Git repository, such as `https://github.com/forkhome/kubernetes-ci-cd`.

### Click `Save`. On the left, click `Build Now` to run the new pipeline. You should see it run through the build, push, and deploy steps in a few seconds.

### After all pipeline stages are colored green as complete, view the Hello application.
```
minikube service hello-cicd
```

NOTE: make sure the IP address in `tools/provision/manifests/jenkins.yaml` line #62 is the IP address when you run `minikube ip`, like:
```
$ minikube ip
192.168.99.110
```
Keep the IP address in the above file SAME:
```
kubectl config set-cluster minikube --server="https://192.168.99.110:8443" ...
```
