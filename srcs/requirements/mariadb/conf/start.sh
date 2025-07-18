#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize DB if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
    echo "Running initial SQL script..."
    mysqld --user=mysql --bootstrap < conf/init.sql
fi

chmod -R 777 /var/lib/mysql
exec mysqld --user=mysql --console
