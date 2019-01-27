### Build Docker image
```
$ docker build -t rili/django_projects .
```

### Tag

### Publish / Push to Docker Registry


### Debugging docker instance
```
$ docker events&
```
to display docker events, run this command before running `docker run ...`


```
$ docker inspect <instance_id>
```
### References
https://serverfault.com/questions/596994/how-can-i-debug-a-docker-container-initialization
https://medium.freecodecamp.org/docker-entrypoint-cmd-dockerfile-best-practices-abc591c30e21
