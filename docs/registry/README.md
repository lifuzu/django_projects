# Create a local Docker image Registry in cluster
https://itfromzero.com/en/docker-en/install-docker-registry-and-web-ui.html

While Docker Hub is great for public images, setting up a private image repository on the site involves some security key overhead that we don’t want to deal with. Instead, we’ll set up our own local image registry.

### Set up the cluster registry by applying a .yaml manifest file.
```
$ kubectl apply -f tools/provision/manifests/registry.yaml
```

### Wait for the registry to finish deploying using the following command. Note that this may take several minutes.
```
$ kubectl rollout status deployments/registry
```

### View the registry user interface in a web browser. Right now it’s empty, but you’re about to change that.
```
$ minikube service registry-webui
```

### References:
- https://hub.docker.com/_/registry