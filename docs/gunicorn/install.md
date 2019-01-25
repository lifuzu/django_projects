
# Install/run Gunicorn
https://docs.djangoproject.com/en/2.1/howto/deployment/wsgi/gunicorn/

```
(django_projects) bash-3.2$ pipenv install gunicorn
(django_projects) bash-3.2$ gunicorn projects.wsgi
```
### Config Gunicorn by editing conf/gunicorn.py

### Tuning Gunicorn workers dynamically
```
# To increase the worker count by one for Gunicorn:
$ kill -TTIN $masterpid
($masterpid is the smallest PID)

# To decrease the worker count by one:
$ kill -TTOU $masterpid
```
### Reference:
http://docs.gunicorn.org/en/stable/faq.html
