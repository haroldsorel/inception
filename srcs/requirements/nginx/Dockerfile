FROM nginx:1.25

COPY conf/hsorel.crt /etc/ssl/certs/server.crt
COPY conf/hsorel.key /etc/ssl/private/server.key

COPY conf/default.conf /etc/nginx/conf.d/default.conf
