"""
Start worker:
    $ celery -A <django_project_name: projects> worker -l info
"""
from __future__ import absolute_import, unicode_literals
from celery import shared_task


@shared_task
def add(x, y):
    return x + y


@shared_task
def mul(x, y):
    return x * y


@shared_task
def xsum(numbers):
    return sum(numbers)

@shared_task
def trigger_job(job_url: str, job_params: dict) -> dict:
    print("triggered a Jenkins job: {}, {}".format(job_url, job_params))
    return { "okay": True, "info": None }