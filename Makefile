DOCKER_COMPOSE?=docker-compose
DOCKER_COMPOSE_RUN=run --rm
DOCKER_COMPOSE_EXEC=exec
DEV_SERVICES=postgres adminerdg

.PHONY: build
build:
	$(DOCKER_COMPOSE) build --no-cache $(DEV_SERVICES)

.PHONY: up
up:
	$(DOCKER_COMPOSE) up -d --build $(DEV_SERVICES)

.PHONY: restart
restart:
	make down ;\
	make up

.PHONY: clean
clean:
	$(DOCKER_COMPOSE) stop ;\
	$(DOCKER_COMPOSE) rm -f

.PHONY: down
down:
	$(DOCKER_COMPOSE) down