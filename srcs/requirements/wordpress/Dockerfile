FROM debian:bookworm

#installs necessary software wordpress + php
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y \
    php-fpm \
    php-mysqli \
    curl

#copies my conf to the container. Changes the default
# /run/php/php8.2-fpm.sock address to wp-php:9000
#because my wordpress-php container lives in port 90000
COPY conf/www.conf /etc/php/8.2/fpm/pool.d
COPY conf/script.sh script.sh

RUN chmod +x script.sh

#what does CMD do again...
CMD ["./script.sh"]
