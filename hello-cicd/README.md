### Create Dockerfile and related resource under the folder: `tools/application/hello-cicd`

### Create Docker image
```
$ docker build -t 127.0.0.1:30400/hello-cicd:latest -f tools/applications/hello-cicd/Dockerfile tools/applications/hello-cicd
```

### Push the Docker image `hello-cicd` to cluster registry (with socat proxy)
# Run the socat proxy container (Refer to socat/README.md)
```
$ docker push 127.0.0.1:30400/hello-cicd:latest
```

### Manully deploy the service once:
```
$ kubectl apply -f tools/deployment/k8s/hello-cicd/manual-deployment.yaml
service/hello-cicd created
deployment.extensions/hello-cicd created
```
### Rollout the deployment
```
$ kubectl rollout status deployment/hello-cicd
```