#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

# Initialize DB if empty
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql

    echo "Running initial SQL script..."
    mysqld --user=mysql --bootstrap < /etc/mysql/init.sql

fi

# Start MariaDB in foreground
exec mysqld --user=mysql --console
