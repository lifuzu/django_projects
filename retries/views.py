from retries.models import Retry
from retries.serializers import RetrySerializer
from rest_framework import generics

class RetryListCreate(generics.ListCreateAPIView):
    queryset = Retry.objects.all()
    serializer_class = RetrySerializer
