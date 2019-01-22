import json
from .tasks import trigger_job

def create_retry_task(sender, instance, created, **kwargs):
    print("status: {}".format(instance.status))
    print("job url: {}".format(instance.job_url))
    print("retry created!")
    job_result = trigger_job.delay(instance.job_url, instance.job_params)
    print("Trigger job results: {}".format(job_result))
