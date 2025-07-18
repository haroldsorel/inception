#!/bin/bash

#wait for everything else to setup CHANGE THIS SOON
sleep 10

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root

./wp-cli.phar config create \
    --dbname=wordpress \
    --dbuser=wpuser \
    --dbpass=wppassword \
    --dbhost=mariadb \
    --allow-root

#change localhost 8080 to 80!
./wp-cli.phar core install \
    --url=https://localhost:8080 \
    --title="Inception" \
    --admin_user=admin \
    --admin_password=admin \
    --admin_email=admin@admin.com \
    --allow-root

#to map to 8080 because it was redirecting to 80 before
#./wp-cli.phar option update siteurl http://localhost:8080 --allow-root
#./wp-cli.phar option update home http://localhost:8080 --allow-root

exec php-fpm8.2 -F