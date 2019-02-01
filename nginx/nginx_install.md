### Install/config/run Nginx
https://gist.github.com/netpoetica/5879685

```
# Install Nginx on Mac with brew
$ brew install nginx

# Run Nginx
$ ngnix

# Stop Ngnix
$ ngnix -s stop

# Config Ngnix:
#  1. Backup before making change(s)
$ cp /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.bak

#  2. Prepare ENV variable(s)
$ source .env

#  3. Create a site config file
$ touch /usr/local/etc/nginx/servers/${DOMAIN_NAME}.conf

#  4. Copy the Ngnix template
$ cp tools/templates/nginx.template.conf /usr/local/etc/nginx/servers/${DOMAIN_NAME}.conf

#  5. Replace the DOMAIN, DEPLOY_HOME
$ sed -i.bak "s/DOMAIN/${DOMAIN_NAME}/g" /usr/local/etc/nginx/servers/${DOMAIN_NAME}.conf
$ sed -i.bak "s|DEPLOY_HOME|${DEPLOY_HOME}|g" /usr/local/etc/nginx/servers/${DOMAIN_NAME}.conf
$ rm /usr/local/etc/nginx/servers/${DOMAIN_NAME}.conf.bak

#  6. Edit hosts
`
$ echo ${DOMAIN_NAME}
rili.local.com

$ sudo vim /private/etc/hosts
...
# Setting Ngnix
127.0.0.1       rili.local.com
`

#  7. Reload Nginx
$ nginx -s reload

#  6. Start the backing Django service
$ (django_projects) bash-3.2$ gunicorn --bind unix:///tmp/${DOMAIN_NAME}.socket projects.wsgi:application

#  7. Open rili.local.com/api/retry in a browser to verify Ngnix
NOTE: no static file(s) ready yet
```