
## Supervisord Init Script, to automatically start supervisord on Linux (Ubuntu)
https://serverfault.com/questions/96499/how-to-automatically-start-supervisord-on-linux-ubuntu

### to run it
```
sudo mv tools/templates/supervisord.sh /etc/init.d/supervisord
sudo chmod +x /etc/init.d/supervisord
```
### and to automatically schedule it, do
```
sudo update-rc.d supervisord defaults
```
### make ensure correct pid in /etc/supervisord.conf which is mapped in /etc/init.d/supervisord
```
example: pidfile=/var/run/supervisord.pid
```
### stop and start work properly
```
service supervisord stop
service supervisord start
```
