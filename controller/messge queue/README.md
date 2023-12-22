
# Install and configure components

 #### Install the package:
```
apt install rabbitmq-server
```
Add the openstack user:
```
rabbitmqctl add_user openstack RABBIT_PASS
```
Creating user "openstack" ...
Replace RABBIT_PASS with a suitable password.

Permit configuration, write, and read access for the openstack user:
```
rabbitmqctl set_permissions openstack ".*" ".*" ".*"
```
Setting permissions for user "openstack" in vhost "/" ...

