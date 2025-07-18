FROM debian:bookworm

RUN apt-get update -y && apt-get install -y \
    mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY conf/init.sql /etc/mysql/init.sql
COPY conf/start.sh start.sh 

#add permissions?
RUN mkdir -p /run/mysqld

RUN chmod +x start.sh

CMD ["./start.sh"]