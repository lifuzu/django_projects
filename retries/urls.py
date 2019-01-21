from django.urls import path
from . import views

urlspattern = [
    path('api/retry', views.RetryListCreate.as_view()),
]