docker-compose.md

```
docker-compose config
```

```
DOCKER_HOST_IP=$(ifconfig | grep 'inet .*br' | sed -E 's/.*inet (.*) netmask.*/\1/')
```