
### Install Supervisor on Mac
https://gist.github.com/fadhlirahim/78fefdfdf4b96d9ea9b8
https://nicksergeant.com/running-supervisor-on-os-x/

### Install Supervisor with pipenv
```
$ brew install supervisor
# OR ( above ^ is better )
$ pipenv run pip install git+https://github.com/Supervisor/supervisor
```

### Use Supervisord template config file and edit
```
$ cp tools/templates/supervisord.template.conf ${CONFIG_HOME}/supervisor/supervisord.conf

$ source .env

$ sed -i.bak "s/DOMAIN/${DOMAIN_NAME}/g" ${CONFIG_HOME}/supervisor/supervisord.conf
$ sed -i.bak "s|DEPLOY_HOME|${DEPLOY_HOME}|g" ${CONFIG_HOME}/supervisor/supervisord.conf
$ sed -i.bak "s/DEPLOY_USER/${DEPLOY_USER}/g" ${CONFIG_HOME}/supervisor/supervisord.conf
$ rm ${CONFIG_HOME}/supervisord.conf.bak
```

### Define a function to reverse domain name, as well as reverse ip address
```
function reverse_domain_name {
    local domain_name=$1
    echo $domain_name | awk '{n=split($0,A,".");S=A[n];{for(i=n-1;i>0;i--)S=S"."A[i]}}END{print S}'
}

function reverse_ip_addr {
    local ip_addr=$1
    echo $ip_addr | awk '{n=split($0,A,".");S=A[n];{for(i=n-1;i>0;i--)S=S"."A[i]}}END{print S}'
}
```

### Create Supervisor plist
```
$ REVERSE_DOMAIN=$(reverse_domain_name ${DOMAIN_NAME})
$ cp tools/templates/supervisord.template.plist /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist
$ sed -i.bak "s/REVERSE_DOMAIN/${REVERSE_DOMAIN}/g" /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist
$ sed -i.bak "s|DEPLOY_HOME|${DEPLOY_HOME}|g" /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist
$ sed -i.bak "s|CONFIG_HOME|${CONFIG_HOME}|g" /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist
$ rm /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist.bak
```

### Register the plist
```
$ launchctl load /Library/LaunchDaemons/${REVERSE_DOMAIN}.supervisord.plist
```
