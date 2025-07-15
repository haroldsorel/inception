#!/bin/sh
set -e

echo "🟢 Starting MariaDB custom entrypoint..."

# ✅ Comment out bind-address and skip-networking in Debian config
sed -i 's/^bind-address/#bind-address/' /etc/mysql/mariadb.conf.d/50-server.cnf || true
sed -i 's/^skip-networking/# skip-networking/' /etc/mysql/mariadb.conf.d/50-server.cnf || true

# ✅ Make sure /run/mysqld exists
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown mysql:mysql /run/mysqld
    chmod 750 /run/mysqld
fi

# ✅ Initialize database if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "🟡 No system tables found, initializing..."
    chown -R mysql:mysql /var/lib/mysql
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql

    echo "🟡 Starting mysqld temporarily for setup..."
    mysqld --user=mysql --skip-networking &
    pid="$!"

    echo "🟡 Waiting for server to be ready..."
    until mysqladmin ping --silent; do
        printf '.'
        sleep 1
    done
    echo

    echo "🟡 Running initial SQL setup..."
    mariadb -u root -e "DROP DATABASE IF EXISTS test;"
    mariadb -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MARIADB_ROOT_PASSW}');"
    mariadb -u root -e "CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8 COLLATE utf8_general_ci;"
    mariadb -u root -e "CREATE USER 'wordpress'@'%' IDENTIFIED BY '${MARIADB_WP_PASSW}';"
    mariadb -u root -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%';"
    mariadb -u root -e "FLUSH PRIVILEGES;"

    echo "🟡 Shutting down temporary server..."
    mysqladmin -u root -p"${MARIADB_ROOT_PASSW}" shutdown

    wait "$pid"
fi

echo "🟢 Final mysqld launch..."
exec mysqld --user=mysql
