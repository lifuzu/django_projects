
### Install flower for monitoring and administrating Celery clusters
https://flower.readthedocs.io/en/latest/index.html
```
(django_projects) bash-3.2$ pipenv install flower
```
### Run the flower (require redis server ON, celery ON, Django ON)
```
(django_projects) bash-3.2$ flower -A projects --port=5555
```
