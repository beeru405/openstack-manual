
    2  nano /etc/network/interfaces
    3  reboot
    4  script
    5  nano /etc/hosts
    6  ping compute1
    7  ping block1
    8  apt install chrony -y
    9  nano /etc/chrony/chrony.conf
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
   29  history
   30  mysql
   31  apt install keystone
   32  nano /etc/keystone/keystone.conf
   33  su -s /bin/sh -c "keystone-manage db_sync" keystone
   34  keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
   35  keystone-manage credential_setup --keystone-user keystone --keystone-group keystone
   36  keystone-manage bootstrap --bootstrap-password idrbt   --bootstrap-admin-url http://controller:5000/v3/   --bootstrap-internal-url http://controller:5000/v3/   --bootstrap-public-url http://controller:5000/v3/   --bootstrap-region-id RegionOne
   37  nano /etc/apache2/apache2.conf
   38  service apache2 restart
   39  export OS_USERNAME=admin
   40  export OS_PASSWORD=idrbt
   41  export OS_PROJECT_NAME=admin
   42  export OS_USER_DOMAIN_NAME=Default
   43  export OS_PROJECT_DOMAIN_NAME=Default
   44  export OS_AUTH_URL=http://controller:5000/v3
   45  export OS_IDENTITY_API_VERSION=3
   46  openstack domain create --description "An Example Domain" example
   47  openstack project create --domain default   --description "Service Project" service
   48  openstack project create --domain default   --description "Demo Project" myproject
   49  openstack user create --domain default   --password-prompt myuser
   50  openstack role create myrole
   51  openstack role add --project myproject --user myuser myrole
   52  unset OS_AUTH_URL OS_PASSWORD
   53  openstack --os-auth-url http://controller:5000/v3   --os-project-domain-name Default --os-user-domain-name Default   --os-project-name admin --os-username admin token issue
   54  openstack --os-auth-url http://controller:5000/v3   --os-project-domain-name Default --os-user-domain-name Default   --os-project-name myproject --os-username myuser token issue
   55  nano admin-openrc
   56  nano demo-openrc
   57  . admin-openrc 
   58  openstack token issue
   59  mysql
   60  openstack user create --domain default --password-prompt glance
   61  openstack role add --project service --user glance admin
   62  openstack service create --name glance   --description "OpenStack Image" image
   63  openstack endpoint create --region RegionOne   image public http://controller:9292
   64  openstack endpoint create --region RegionOne   image internal http://controller:9292
   65  openstack endpoint create --region RegionOne   image admin http://controller:9292
   66  apt install glance
   67  nano /etc/glance/glance-api.conf
   68  su -s /bin/sh -c "glance-manage db_sync" glance
   69  service glance-api restart
   70  wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
   71  glance image-create --name "cirros"   --file cirros-0.4.0-x86_64-disk.img   --disk-format qcow2 --container-format bare   --visibility=public
   72  glance image-list
   73  mysql
   74  openstack user create --domain default --password-prompt placement
   75  openstack role add --project service --user placement admin
   76  openstack service create --name placement   --description "Placement API" placement
   77  openstack endpoint create --region RegionOne   placement public http://controller:8778
   78  openstack endpoint create --region RegionOne   placement internal http://controller:8778
   79  openstack endpoint create --region RegionOne   placement admin http://controller:8778
   80  apt install placement-api -y
   81  nano /etc/placement/placement.conf
   82  su -s /bin/sh -c "placement-manage db sync" placement
   83  service apache2 restart
   84  placement-status upgrade check
   85  pip3 install osc-placement
   86  apt install python3-pip
   87  pip3 install osc-placement
   88  openstack --os-placement-api-version 1.2 resource class list --sort-column name
   89  openstack --os-placement-api-version 1.6 trait list --sort-column name
   90  mysql
   91  openstack user create --domain default --password-prompt nova
   92  openstack role add --project service --user nova admin
   93  openstack service create --name nova   --description "OpenStack Compute" compute
   94  openstack endpoint create --region RegionOne   compute public http://controller:8774/v2.1
   95  openstack endpoint create --region RegionOne   compute internal http://controller:8774/v2.1
   96  openstack endpoint create --region RegionOne   compute admin http://controller:8774/v2.1
   97  apt install nova-api nova-conductor nova-novncproxy nova-scheduler
   98  nano /etc/nova/nova.conf
   99  su -s /bin/sh -c "nova-manage api_db sync" nova
  100  su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
  101  su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
  102  su -s /bin/sh -c "nova-manage db sync" nova
  103  su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova
  104  service nova-api restart
  105  service nova-scheduler restart
  106  service nova-conductor restart
  107  service nova-novncproxy restart
  108  openstack compute service list --service nova-compute
  109  su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
  110  mysql
  111  openstack user create --domain default --password-prompt neutron
  112  openstack role add --project service --user neutron admin
  113  openstack service create --name neutron   --description "OpenStack Networking" network
  114  openstack endpoint create --region RegionOne   network internal http://controller:9696
  115  openstack endpoint create --region RegionOne   network admin http://controller:9696
  116  apt install neutron-server neutron-plugin-ml2   neutron-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent   neutron-metadata-agent
  117  nano /etc/neutron/neutron.conf
  118  nano /etc/neutron/plugins/ml2/ml2_conf.ini
  119  nano /etc/neutron/plugins/ml2/linuxbridge_agent.ini
  120  nano /etc/neutron/l3_agent.ini
  121  nano /etc/neutron/dhcp_agent.ini
  122  nano  /etc/neutron/metadata_agent.ini
  123  nano /etc/nova/nova.conf 
  124  su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf \
  --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron
  125  service nova-api restart
  126  service neutron-server restart
  127  service neutron-linuxbridge-agent restart
  128  service neutron-dhcp-agent restart
  129  service neutron-metadata-agent restart
  130  service neutron-l3-agent restart
  131  openstack extension list --network
  132  openstack network agent list
  133  apt install openstack-dashboard
  134  nano /etc/openstack-dashboard/local_settings.py
  135  systemctl reload apache2.service


