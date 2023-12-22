apt install chrony -y
nano /etc/chrony/chrony.conf
   10  service chrony restart
   11  chronyc sources
   12  add-apt-repository cloud-archive:victoria
   13  apt install nova-compute
   14  apt install python3-openstackclient
   15  apt install mariadb-server python3-pymysql
   16  nano /etc/mysql/mariadb.conf.d/99-openstack.cnf
   17  service mysql restart
   18  mysql_secure_installation
   19  apt install rabbitmq-server -y
   20  rabbitmqctl add_user openstack idrbt
   21  rabbitmqctl set_permissions openstack ".*" ".*" ".*"
   22  apt install memcached python3-memcache -y
   23  nano  /etc/memcached.conf
   24  service memcached restart
   25  apt install etcd
   26  nano /etc/default/etcd
   27  systemctl enable etcd
   28  systemctl restart etcd

