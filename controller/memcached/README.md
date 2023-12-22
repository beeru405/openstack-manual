
## Install and configure components

#### Install the packages:

For Ubuntu 18.04 and newer versions use:
```
apt install memcached python3-memcache
```
Edit the /etc/memcached.conf file and configure the service to use the management IP address of the controller node. This is to enable access by other nodes via the management network:
```
-l <IP address of controller>
```
 Note
 Change the existing line that had -l 127.0.0.1.

### Finalize installation
Restart the Memcached service:
```
service memcached restart
```
