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

$ sed -i.bak "s/DOMAIN/${DOMAIN_NAME}/g" /etc/supervisor/conf.d/supervisord.conf
$ sed -i.bak "s|DEPLOY_HOME|${DEPLOY_HOME}|g" /etc/supervisor/conf.d/supervisord.conf
$ sed -i.bak "s/DEPLOY_USER/${DEPLOY_USER}/g" /etc/supervisor/conf.d/supervisord.conf
$ rm /etc/supervisor/conf.d/supervisord.conf.bak
```

### Install Supervisor on MacOS
```
$ brew install supervisor

# export the defined environmental variables
$ source .env

# Edit to uncomment the below two lines in
# /usr/local/etc/supervisord.ini
# ;[inet_http_server]         ; inet (TCP) server disabled by default
# ;port=127.0.0.1:9001        ; ip_address:port specifier, *:port for all iface
$ sed -i.bak -e "s/\;\(\[inet_http_server\]\)/\1/g" ${CONFIG_HOME}/supervisord.ini
$ sed -i.bak -e "s/\;\(port=127.0.0.1:9001\)/\1/g" ${CONFIG_HOME}/supervisord.ini
$ rm ${CONFIG_HOME}/supervisord.ini.bak

# Copy the template and edit
# to create a file, like: /usr/local/etc/supervisor.d/rili.local.com.ini
$ cp tools/templates/supervisord.template.conf ${CONFIG_HOME}/supervisor.d/${DOMAIN_NAME}.ini
$ sed -i.bak "s/DOMAIN/${DOMAIN_NAME}/g" ${CONFIG_HOME}/supervisor.d/${DOMAIN_NAME}.ini
$ sed -i.bak "s|DEPLOY_HOME|${DEPLOY_HOME}|g" ${CONFIG_HOME}/supervisor.d/${DOMAIN_NAME}.ini
$ sed -i.bak "s/DEPLOY_USER/${DEPLOY_USER}/g" ${CONFIG_HOME}/supervisor.d/${DOMAIN_NAME}.ini
$ rm ${CONFIG_HOME}/supervisor.d/${DOMAIN_NAME}.ini.bak

# Start
$ pipenv run supervisord -n -c /usr/local/etc/supervisord.ini

# Reload if any config changed
$ pipenv run supervisorctl -c /usr/local/etc/supervisord.ini reload
```

### Start the supervisor daemon
```
$ supervisorctl start projects
$ supervisorctl start celery
$ supervisorctl start flower
# OR
$ supervisorctl start all
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