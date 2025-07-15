FROM debian:bookworm

RUN apt update && \
    apt install -y mariadb-server && \
    rm -rf /var/lib/apt/lists/*

COPY ./conf/start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]
EXPOSE 3306
