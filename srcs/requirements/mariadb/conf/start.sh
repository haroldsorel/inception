#!/bin/bash

#REMEMBER THIS IS INSIDE A CONTAINER!

#this is all executed by root in the container
#but when mariaDB will run it will do so as a dedicated linux user called mysql
#this is why there is chown mysql:mysql so when MariaDB will run it will have correct permissions 

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

# Disable bind-address to allow external connections


# Ensure runtime directory exists with correct permissions
# MariaDB expects this and Debian doesn´t offer it so we do it ourselve
# Mariadb runs as Daemon so change the ownership otherwise it will have a permission error
if [ ! -d "/run/mysqld" ]; then
    mkdir -p /run/mysqld
    chown -R mysql:mysql /run/mysqld
fi

#initialize databse
if [ ! -d "/var/lib/mysql/mysql" ]; then
    chown -R mysql:mysql /var/lib/mysql

    #initialization of the Mariadb directory (VOLUME!)
    #assigns ownership to mysql (mariadb daemon)
    mysql_install_db > dev/null #--user=mysql --datadir=/var/lib/mysql > dev/null

    #this part starts mariaDB but just to change the users
    #start MariaDB in the background quietly as mysql
    #skip networking so that wordpress doesnt connect to it before the modification
    /usr/sbin/mysqld --skip-networking > dev/null & 

    # Wait for MariaDB to be ready before entering commands
    until mysqladmin ping --user=${MARIADB_USER} --silent; do
        sleep 1
    done

    # SQL setup
    echo -e "${YELLOW}Setting up database...${RESET}"

    echo -e "${BLUE}Setting root password for 'root'@'localhost'...${RESET}"
    mariadb -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}';"

    echo -e "${BLUE}Removes default database...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "DROP DATABASE IF EXISTS test;"

    echo -e "${BLUE}Deleting unsafe root users...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "DELETE FROM mysql.user WHERE user='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "DELETE FROM mysql.user WHERE user='';"

    echo -e "${BLUE}Creating database '${MARIADB_NAME}'...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;"

    echo -e "${BLUE}Creating user '${MARIADB_USER}' for remote connections...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MARIADB_USER}'@'%' IDENTIFIED BY '${MARIADB_USER_PASSWORD}';"

    echo -e "${BLUE}Granting privileges to user '${MARIADB_USER}' on '${MARIADB_NAME}'...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MARIADB_NAME}\`.* TO '${MARIADB_USER}'@'%';"

    echo -e "${BLUE}Flushing privileges to apply changes...${RESET}"
    mariadb -u root -p"${MARIADB_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    echo -e "${GREEN}Database Set!${RESET}"

    # Shut down MariaDB quietly to lock-in changes
    mysqladmin -u root -p"${MARIADB_ROOT_PASSWORD}" shutdown > dev/null
    fi

chmod -R 777 /var/lib/mysql #so i can easily remove it

# Start the real server
echo -e "${GREEN}Lauching Mariadb!${RESET}"
exec mysqld --console
