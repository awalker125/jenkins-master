
# Filenames
COMPOSE_FILE := docker-compose.yml

.PHONY: up down

up:
	${INFO} "Deploying environment..."
	@ docker-compose -f $(COMPOSE_FILE) up -d
	
down:
	${INFO} "Destroying environment..."
	@ docker-compose -f $(COMPOSE_FILE) down -v


	
# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell Functions
INFO := @bash -c '\
  printf $(YELLOW); \
  echo "=> $$1"; \
  printf $(NC)' SOME_VALUE