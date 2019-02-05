
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
edadcf9de1174a9794d2dcf52d8e0ea3
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

###