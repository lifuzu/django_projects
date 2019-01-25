# thoughts on conf folder structure

```
conf/
    <common_or_unified_conf_file(s)>
    dev/<conf_file(s)_fitting_for_*dev*_environment>
    qa/<conf_file(s)_fitting_for_*QA*_environment>
    stag/<conf_file(s)_fitting_for_*staging*_environment>
    prod/<conf_file(s)_fitting_for_*production*_environment>

    # the above conf files should be set in .env and/or env/.*

    env/.qa
    env/.stag
    env/.prod

    # .env (under project root) will be checked into source code repo for *dev* purpose;
    # env/.* will be copied/overwrited to .env according to different deployment environment;

    env/check/dev
             /qa
             /stag
             /prod

    # env/check/[dev|qa|stag|prod] includes some commands/scripts
    # to check node environment for *dev/qa/staging/production*

    secure/

    # env related files should not have any secure keys, credentials, passwords, tokens, etc.
    # those secure info should be provisioned to conf/secure folder,
    # either through docker mount point, copy with Fabric/chef/ansible deployment script.
```



:

```
# DOMAIN_NAME must be here
SITENAME=rili.local.com
DOMAIN_NAME=${SITENAME}
```