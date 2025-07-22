#!/bin/bash

#wait for everything else to setup CHANGE THIS SOON
sleep 20

cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root

#creates the wp-config.php (creates the database, in this case MariaDB credentials)
#tells wordpress how to connect to mariaDB
./wp-cli.phar config create \
    --dbname=$MARIADB_NAME \
    --dbuser=$MARIADB_USER \
    --dbpass=$MARIADB_USER_PASSW \
    --dbhost=mariadb \
    --allow-root #by default wordpress runs as a user and not root but you are a root in  the container so just put this to avoid an error 

#change localhost 8080 to 80!
./wp-cli.phar core install \
    --url=$DOMAIN_NAME \
    --title="Inception" \
    --admin_user=$WP_ADMIN_USR \
    --admin_password=$WP_ADMIN_PASSW \
    --admin_email=$WP_ADMIN_EMAIL \
    --allow-root

./wp-cli.phar user create \
    $WP_STD_USR \
    $WP_STD_EMAIL \
    --user_pass=$WP_STD_PASSW \
    --role=author \
    --allow-root #have a doubt on role editor

#chown -R wordpress:wordpress /var/www/html
#chmod -R 755 /var/www/html

exec php-fpm8.2 -F