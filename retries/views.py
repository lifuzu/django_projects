from retries.models import Retry
from retries.serializers import RetrySerializer
from rest_framework import generics

from retries.signals import create_retry_task


class RetryListCreate(generics.ListCreateAPIView):
    queryset = Retry.objects.all()
    serializer_class = RetrySerializer

    # Perform a custom pre/post-save action
    # Reference:
    # https://www.django-rest-framework.org/api-guide/generic-views/
    def perform_create(self, serializer):
        instance = serializer.save()
        # Perform a custom post-save action after a new data inserted.
        create_retry_task(sender=self, instance=instance, created=True)

    def perform_update(self, serializer):
        instance = serializer.save()
        # Perform a custom post-save action after a data updated.
        create_retry_task(sender=self, instance=instance, created=True)