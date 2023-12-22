## Prerequisites

Before you install and configure the Identity service, you must create a database.
Use the database access client to connect to the database server as the root user:
```
mysql
```
Create the keystone database:
```
MariaDB [(none)]> CREATE DATABASE keystone;
```
Grant proper access to the keystone database:
```
MariaDB [(none)]> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'localhost' \
IDENTIFIED BY 'KEYSTONE_DBPASS';

MariaDB [(none)]> GRANT ALL PRIVILEGES ON keystone.* TO 'keystone'@'%' \
IDENTIFIED BY 'KEYSTONE_DBPASS';
```    
Replace KEYSTONE_DBPASS with a suitable password.
Exit the database access client.

