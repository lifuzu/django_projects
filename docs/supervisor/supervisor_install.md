# Install Supervisor on Ubuntu 16.04


```
root@ubuntu-s-1vcpu-1gb-sfo2-01:~# apt-get update
Get:1 http://security.ubuntu.com/ubuntu xenial-security InRelease [109 kB]
Hit:2 http://sfo1.mirrors.digitalocean.com/ubuntu xenial InRelease
...
Fetched 25.8 MB in 5s (4,503 kB/s)
Reading package lists... Done
```
```
root@ubuntu-s-1vcpu-1gb-sfo2-01:~# apt-get install -y supervisor
Reading package lists... Done
Building dependency tree
...
Processing triggers for systemd (229-4ubuntu21.10) ...
Processing triggers for ureadahead (0.100.0-19) ...
```

### Use Supervisord template config file and edit
```
$ DEPLOY_USER=deploy
$ DOMAIN_NAME=rili.local.com
$ DEPLOY_HOME=/home/${DEPLOY_USER}/sites/${DOMAIN_NAME}

$ cp tools/templates/supervisord.template.conf /etc/supervisor/conf.d/supervisord.conf

$ sed -i.bak 's/DOMAIN/${DOMAIN_NAME}/g' /etc/supervisor/conf.d/supervisord.conf
$ sed -i.bak 's/DEPLOY_HOME/${DEPLOY_HOME}/g' /etc/supervisor/conf.d/supervisord.conf
$ sed -i.bak 's/DEPLOY_USER/${DEPLOY_USER}/g' /etc/supervisor/conf.d/supervisord.conf
```

### Start the supervisor daemon
```
$ supervisorctl start projects
$ supervisorctl start celery
$ supervisorctl start flower
```

### TODO: Install / launch Redis

### TODO: Install / launch PostgreSQL

### TODO: Create deploy USER and deployemnt HOME
```
$ DEPLOY_USER=deploy
$ DEPLOY_HOME=/home/${DEPLOY_USER}/sites/${DOMAIN_NAME}
```

### Update Supervisor config if any change(s)
```
$ supervisorctl reread
$ supervisorctl update
```

### Setting up Supervisor web interface
```
# Open up /etc/supervisor/supervisor.conf and place these lines at the beginning of the file:

[inet_http_server]
port=0.0.0.0:9001

# The Supervisor web interface will run on 0.0.0.0:9001
```

### Reload the Supervisor
```
$ supervisorctl reload
```