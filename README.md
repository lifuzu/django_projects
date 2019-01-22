
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
