
# Filenames
COMPOSE_FILE := docker-compose.yml

.PHONY: up down help vm

up:
	${INFO} "Deploying environment..."
	@ docker-compose -f $(COMPOSE_FILE) up -d
	
down:
	${INFO} "Destroying environment..."
	@ docker-compose -f $(COMPOSE_FILE) down -v

help:
#	@echo "This project assumes that an active Python virtualenv is present."
	@echo "The following make targets are available:"
	@echo "		up	- start the vm1 via azure arm"

MAKEFILE_DIR=$(dir $(firstword $(MAKEFILE_LIST)))

vm:
	${INFO} "up..."
	pwd
	${INFO} "login.."
	az login --service-principal -u $(AZURE_CLIENT_ID) -p $(AZURE_SECRET) --tenant $(AZURE_TENANT) > /dev/null
	${INFO} "switch subscription.."
	az account set --subscription $(AZURE_SUBSCRIPTION_ID)
	${INFO} "start vm1.."
	az vm start --resource-group aw125-jenkins-rg --name jenkins
	${INFO} "logout.."
	az logout
	
# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell Functions
INFO := @bash -c '\
  printf $(YELLOW); \
  echo "=> $$1"; \
  printf $(NC)' SOME_VALUE