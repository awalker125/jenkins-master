# Project variables

export ORG_NAME ?= aw125
export APPLICATION ?= jenkins
#export VERSION ?= 0.1
export DOCKER_REGISTRY ?= localhost:443
# WARNING: Set DOCKER_REGISTRY_AUTH to empty for Docker Hub
# Set DOCKER_REGISTRY_AUTH to auth endpoint for private Docker registry
DOCKER_REGISTRY_AUTH ?= localhost:443


MAKEFILE_DIR=$(dir $(firstword $(MAKEFILE_LIST)))
# Filenames
DOCKER_FILE := Dockerfile


COMMIT_EXPRESSION ?= git log -n 1 --pretty=format:"%H"

export COMMIT := $(shell $(COMMIT_EXPRESSION))

#if there is no tag we fall back to the commit id
GIT_TAG_EXPRESSION ?= git describe --tags || git log -n 1 --pretty=format:"%H"

export GIT_TAG := $(shell $(GIT_TAG_EXPRESSION))


.PHONY: build clean  login interactive logout publish

build:
	${INFO} "Building images..."
	docker build \
	-t $(DOCKER_REGISTRY)/$(ORG_NAME)/$(APPLICATION):$(GIT_TAG) \
	-f $(DOCKER_FILE) $(MAKEFILE_DIR) 
	
	

login:
	${INFO} "Logging in to Docker registry $$DOCKER_REGISTRY..."
	@ docker login -u $$DOCKER_USER -p $$DOCKER_PASSWORD $(DOCKER_REGISTRY_AUTH)
	${INFO} "Logged in to Docker registry $$DOCKER_REGISTRY"

interactive:
	${INFO} "Logging in to Docker registry $$DOCKER_REGISTRY..."
	@ docker login $(DOCKER_REGISTRY_AUTH)
	${INFO} "Logged in to Docker registry $$DOCKER_REGISTRY"


logout:
	${INFO} "Logging out of Docker registry $$DOCKER_REGISTRY..."
	@ docker logout $(DOCKER_REGISTRY_AUTH)
	${INFO} "Logged out of Docker registry $$DOCKER_REGISTRY"	

publish:
	${INFO} "Publishing release image) to $(DOCKER_REGISTRY)/$(ORG_NAME)/$(APPLICATION):$(GIT_TAG)"
	@ docker push $(DOCKER_REGISTRY)/$(ORG_NAME)/$(APPLICATION):$(GIT_TAG)
	${INFO} "Publish complete"
	
# Cosmetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell Functions
INFO := @bash -c '\
  printf $(YELLOW); \
  echo "=> $$1"; \
  printf $(NC)' SOME_VALUE


