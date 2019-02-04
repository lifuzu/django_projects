# Set up a socat proxy, from local to cluster

By default the Docker client can only push to HTTP (not HTTPS) via localhost. To work around this, we’ll set up a Docker container that listens on 127.0.0.1:30400 and forwards to our cluster.

### Set up the socat proxy Docker container.
```
$ docker build -t socat-proxy -f tools/applications/socat/Dockerfile tools/applications/socat
```

### Run the proxy container from the newly created image.
```
$ docker run -d -e "REG_IP=`minikube ip`" -e "REG_PORT=30400" --name socat-proxy -p 30400:5000 socat-proxy
```

### Stop the proxy container
```
$ docker stop socat-proxy
```

### Remove the proxy container
```
$ docker rm socat-proxy
```