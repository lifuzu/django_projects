## Retries

caught the failed Jenkins' build, retry the build with retry policy

Model:
    status: string, started by 'failed', to 'success';
    caused_by: string, describe the root cause of failure;
    job_url: Jenkins' build URL;
    job_params: job's parameters;
    fallback_email: email address for fallback

Authentication:
    job_user: Jenkins' job user
    job_token: Jenkins' access token for the user

Policy:
    initial_delay: seconds
    max_retries:
    delay: seconds
    backoff: times


Flow:
    1. Customer POST a request for failed build with the model and auth information;
    2. Select, or specify retry policy;
    3. Wait for a initial delay;
    4. trigger a check build (pick from a set of builds which have same caused_by) to try;
        4.1. if failed, increase the current tries time, backoff the delay, set up the time of next try;
        4.2. if succeed, group the set of the failed build with same caused_by, trigger a group of them, set a time to trigger other groups;
    5. If check build failed with the retries policy, send fallback email;


Pick up check build:
    Check the failed build which have same caused_by;
    If found only one, pick the one;
    If found a set of them, pick one randomly;
