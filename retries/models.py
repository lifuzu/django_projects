from django.contrib.postgres.fields import JSONField
from django.db import models

class Retry(models.Model):
    status = models.CharField(max_length=100)
    caused_by = models.CharField(max_length=300)
    job_url = models.CharField(max_length=100)
    job_params = JSONField()
    fallback_email = models.EmailField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
