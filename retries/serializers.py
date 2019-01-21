from rest_framework import serializers
from retries.models import Retry

class RetrySerializer(serializers.ModelSerializer):
    class Meta:
        model = Retry
        fields = ('id', 'status', 'caused_by', 'job_url', 'job_params', 'fallback_email')
