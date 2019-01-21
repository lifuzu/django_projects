from django.urls import path
from . import views

urlpatterns = [
    path('api/retry', views.RetryListCreate.as_view()),
]