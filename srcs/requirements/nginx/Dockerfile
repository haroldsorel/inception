FROM debian:bookworm

#installs necessary software for nginx
RUN apt update -y && apt upgrade -y && apt install -y \
    nginx \
    curl 

#copies nginx conf from my computer to the container si it undertands what to :
# Pass PHP scripts

COPY conf/default.conf /etc/nginx/sites-available/.

#what is cmd for again...
CMD ["nginx", "-g", "daemon off;"]