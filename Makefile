OS := $(shell uname)
VOLUMES = $(docker volume ls -q)

WORDPRESS_VO_DIR = /home/$(USER)/data/wordpress
DB_VO_DIR = /home/$(USER)/data/mariadb

all: volumes-create
	docker compose -f ./srcs/docker-compose.yml up --build

volumes-create:
	@if [ ! -d "$(DB_VO_DIR)" ]; then \
		mkdir -p $(DB_VO_DIR); \
	fi
	@if [ ! -d "${WORDPRESS_VO_DIR}" ]; then \
		mkdir -p $(WORDPRESS_VO_DIR); \
	fi
up:
	docker compose -f ./srcs/docker-compose.yml up --build -d
down:
	docker compose -f ./srcs/docker-compose.yml down
clean:
	docker compose -f ./srcs/docker-compose.yml down -v
re:
	clean all
fclean: clean
	docker system prune -a -f
	docker volume prune -f
	docker network prune -f
	docker container prune -f
	docker image prune -f
	sudo rm -rf ${WORDPRESS_VO_DIR}
	sudo rm -rf $(DB_VO_DIR)