VOLUME_DIR = /home/hsorel/data
MARIADB_VOLUME = $(VOLUME_DIR)/database
WORDPRESS_VOLUME = $(VOLUME_DIR)/wordpress

COMPOSE_DIR = srcs

CERTS_DIR = ./srcs/requirements/nginx/conf
CERT_KEY = $(CERTS_DIR)/hsorel.key
CERT_CRT = $(CERTS_DIR)/hsorel.crt

GREEN  = \033[1;32m
BLUE   = \033[1;34m
RED    = \033[1;31m
RESET  = \033[0m

#@echo "$(GREEN)Creating volumes if not exist...$(RESET)"
#@mkdir -p $(MARIADB_VOLUME)
#@mkdir -p $(WORDPRESS_VOLUME)

all: ssl
	@echo "$(GREEN)Starting containers...$(RESET)"
	cd $(COMPOSE_DIR) && docker-compose up --build

ssl:
	@echo "$(BLUE)Checking for existing SSL certificates...$(RESET)"
	@if [ -f $(CERT_CRT) ] && [ -f $(CERT_KEY) ]; then \
		echo "$(GREEN)SSL certificates already exist. Skipping generation.$(RESET)"; \
	else \
		echo "$(BLUE)Generating new SSL certificates...$(RESET)"; \
		mkdir -p $(CERTS_DIR); \
		openssl req -new -newkey rsa:4096 -x509 -sha512 -days 365 -nodes \
			-subj "/C=BE/ST=Bruxelles/O=19/CN=hsorel.42.fr" \
			-out $(CERT_CRT) \
			-keyout $(CERT_KEY); \
		echo "$(GREEN)SSL certificates created at $(CERTS_DIR)$(RESET)"; \
	fi

clean:
	@echo "$(RED)Stopping and removing containers...$(RESET)"
	cd $(COMPOSE_DIR) && docker-compose down

vclean:
	@echo "$(RED)Deleting volumes...$(RESET)"
	@rm -rf $(MARIADB_VOLUME)
	@rm -rf $(WORDPRESS_VOLUME)

fclean: clean
	@echo "$(RED)Full system prune...$(RESET)"
	docker system prune --all --volumes --force
	@rm -rf $(MARIADB_VOLUME)
	@rm -rf $(WORDPRESS_VOLUME)
	@rm -rf $(CERT_KEY)
	@rm -rf $(CERT_CRT)

re: fclean all

.PHONY: all clean fclean vclean re
