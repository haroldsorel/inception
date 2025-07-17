FROM debian:bookworm

RUN apt-get update -y && apt-get install -y \
    mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.

#add permissions?
RUN mkdir -p /run/mysqld

COPY conf/init.sql /etc/mysql/init.sql 

#cannot be run with mysqld because there is no inventory for sockets in debian
CMD ["mysqld"]