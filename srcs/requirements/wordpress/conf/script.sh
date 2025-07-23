#!/bin/bash

RED='\033[0;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RESET='\033[0m'

if [ ! -f "/var/www/html/wp-config.php" ]; then

    echo -e "${YELLOW}Wordpress is not installed. Installing...${RESET}"

    cd /var/www/html
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar

    ./wp-cli.phar core download --allow-root
    
    until mysqladmin ping --host=mariadb --user=$MARIADB_USER --password=$MARIADB_USER_PASSWORD --silent; do
        echo -e "${YELLOW}Waiting for MariaDB...${RESET}"
        sleep 1
    done
    echo -e "${GREEN}Connection with mariaDB successfull!${RESET}"
    #creates the wp-config.php (creates the database credentials, in this case MariaDB credentials)
    ./wp-cli.phar config create \
        --dbname=$MARIADB_NAME \
        --dbuser=$MARIADB_USER \
        --dbpass=$MARIADB_USER_PASSWORD \
        --dbhost=mariadb \
        --allow-root #by default wordpress runs as a user and not root but you are a root in  the container so just put this to avoid an error 

    #tells wordpress how to connect to mariaDB
    #inserts some values like the title ect
    ./wp-cli.phar core install \
        --url=$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    #creates a random user
    ./wp-cli.phar user create \
        $WP_USER \
        $WP_USER_EMAIL \
        --user_pass=$WP_USER_PASSWORD \
        --role=author \
        --allow-root #have a doubt on role editor
    #chown -R wordpress:wordpress /var/www/html
else
    echo -e "Wordpress is already installed!"
fi

echo -e "${GREEN}Wordpress is Ready${RESET}!"

exec php-fpm8.2 -F