all:
	cd srcs && docker-compose up --build
clean:
	cd srcs && docker-compose down
fclean:		clean
	docker system prune --all --volumes --force
	rm -rf srcs/web
	rm -rf srcs/database

re:		fclean all


.PHONY:			all clean fclean re
