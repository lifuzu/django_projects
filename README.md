
### Create retries Django app
```
# Make sure you're in pipenv shell by running `pipenv shell`
(django_projects) bash-3.2$ python manage.py startapp retries

# Install Postgres server, psycopg2-binary dep (in Pipenv), refer to:
https://tutorial-extensions.djangogirls.org/en/optional_postgresql_installation/

# Create database migrations
(django_projects) bash-3.2$ python manage.py makemigrations retries
(django_projects) bash-3.2$ python manage.py migrate

# Rerun the test coverage, and then create a report
(django_projects) bash-3.2$ pipenv run coverage
(django_projects) bash-3.2$ pipenv run cov_report

# Seeding reties database
(django_projects) bash-3.2$ python manage.py loaddata retries
```


## Learning with following:
https://www.valentinog.com/blog/tutorial-api-django-rest-react/

### Start coverage
```
$ pipenv run coverage
$ pipenv run cov_report
```

### Migrate database
```
$ python manage.py makemigrations <app>
$ python manage.py migrate
```

### Load fixtures data
```
$ python manage.py loaddata leads
```

### Run the frontend and server together
```
$ npm run dev
$ python manage.py runserver
```

### Run the UI test with Cypress
```
# Terminal #1
$ pipenv run python manage.py runserver

# Terminal #2
$ npm run e2e
```

## Learning from following
https://www.revsys.com/tidbits/celery-and-django-and-docker-oh-my/

### Install deps (Celery, Redis)
```
(django_projects) bash-3.2$ pipenv install celery
(django_projects) bash-3.2$ pipenv install redis
```

### Run Celery tasks (with local redis server supported)
```
(django_projects) bash-3.2$ celery -A projects worker -l=info
```

### Install flower for monitoring and administrating Celery clusters
https://flower.readthedocs.io/en/latest/index.html
```
(django_projects) bash-3.2$ pipenv install flower
```
### Run the flower (require redis server ON, celery ON, Django ON)
```
(django_projects) bash-3.2$ flower -A projects --port=5555
```

### Install/run Gunicorn
https://docs.djangoproject.com/en/2.1/howto/deployment/wsgi/gunicorn/
```
(django_projects) bash-3.2$ pipenv install gunicorn
(django_projects) bash-3.2$ gunicorn projects.wsgi
```

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

### Setting up static resource folder
```
# Config STATIC_ROOT in settings.py, then
$ (django_projects) bash-3.2$ python manage.py collectstatic --no-input
```