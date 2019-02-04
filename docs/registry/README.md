# Create a local Docker image Registry in cluster
https://itfromzero.com/en/docker-en/install-docker-registry-and-web-ui.html

While Docker Hub is great for public images, setting up a private image repository on the site involves some security key overhead that we don’t want to deal with. Instead, we’ll set up our own local image registry.

### Set up the cluster registry by applying a .yaml manifest file.
```
$ kubectl apply -f tools/provision/manifests/registry.yaml
persistentvolume/registry created
persistentvolumeclaim/registry-claim created
service/registry created
service/registry-webui created
deployment.extensions/registry created
```

### Wait for the registry to finish deploying using the following command. Note that this may take several minutes.
```
$ kubectl rollout status deployments/registry
deployment "registry" successfully rolled out
```

### View the registry user interface in a web browser. Right now it’s empty, but you’re about to change that.
```
$ minikube service registry-webui
Opening kubernetes service default/registry-webui in default browser...
```

### Trying to push an image to registry
```
$ docker build -t 127.0.0.1:30400/socat-proxy:latest -f tools/applications/socat/Dockerfile tools/applications/socat
# Run the socat proxy container (Refer to socat/README.md)
$ docker push 127.0.0.1:30400/socat-proxy:latest
```

### References:
- https://hub.docker.com/_/registry