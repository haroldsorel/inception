#!/bin/bash

#REMEMBER THIS IS INSIDE A CONTAINER!

#this is all executed by root in the container
#but when mariaDB will run it will do so as a dedicated linux user called mysql
#this is why there is chown mysql:mysql so when MariaDB will run it will have correct permissions 

# Disable bind-address to allow external connections

# Ensure runtime dir exists with correct perms
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
    chmod 755 /run/mysqld
fi

# If no internal mysql DB, then initialize
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql
    mysql_install_db --user=mysql --ldata=/var/lib/mysql > /dev/null

    # Start MariaDB temporarily to change configuration
    /usr/sbin/mysqld --user=mysql --skip-networking &
    
    # Wait for MariaDB to become responsive
    until mysqladmin ping --silent; do
        printf 'waiting for MariaDB\n'
        sleep 1
    done

    #SQL setup
    printf 'Setting up database...\n'
    mariadb -u root <<EOF
    DROP DATABASE IF EXISTS test;
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSW}';
    DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
    DELETE FROM mysql.user WHERE user='';
    CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
    CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSW}';
    GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* TO '${MARIADB_USER}'@'%';
    FLUSH PRIVILEGES;
EOF

    printf 'Database Set!\n'

    # Shutdown temp MariaDB to lock-in new configuration
    mysqladmin -u root -p"${MARIADB_ROOT_PASSW}" shutdown
fi

chmod -R 777 /var/lib/mysql
exec mysqld --user=mysql --console
