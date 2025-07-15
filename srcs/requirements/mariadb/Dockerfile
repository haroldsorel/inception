FROM debian:bookworm

# Install MariaDB server
RUN apt update && apt install -y mariadb-server

# Copy your custom startup script
COPY ./conf/start.sh /start.sh
RUN chmod +x /start.sh

# Define the container entrypoint
ENTRYPOINT ["/start.sh"]

# Expose default MariaDB port
EXPOSE 3306
