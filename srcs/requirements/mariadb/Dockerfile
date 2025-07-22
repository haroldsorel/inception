FROM debian:bookworm

RUN apt-get update -y && apt-get install -y \
    mariadb-server \
    mariadb-client

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY conf/start.sh start.sh 

RUN chmod +x start.sh

CMD ["./start.sh"]