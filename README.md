

### Learning with following:
https://www.valentinog.com/blog/tutorial-api-django-rest-react/

### Start coverage
```
$ pipenv run coverage
$ pipenv run cov_report
```

### Migrate database
```
$ python manage.py makemigration
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