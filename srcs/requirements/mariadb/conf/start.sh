#!/bin/sh
set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing DB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    if [ -f /init.sql ]; then
        echo "Running init.sql..."
        mysqld --bootstrap --user=mysql < /init.sql
    fi
fi

echo "Starting MariaDB as mysql user..."
exec su mysql -c 'mysqld'
