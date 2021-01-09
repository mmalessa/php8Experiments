ALIAS              = php8experiments
BUILD_IMAGE_CLI   ?= php:8.0-cli
####

.DEFAULT_GOAL      = help
PLATFORM          ?= $(shell uname -s)
EXEC_PHP           = php
BIN                = $(ALIAS)-application
REGISTRY          ?= localhost:5000
DOCKER_GATEWAY    ?= $(shell if [ 'Linux' = "${PLATFORM}" ]; then ip addr show docker0 | awk '$$1 == "inet" {print $$2}' | grep -oE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+'; fi)
COMPOSE            = docker-compose
BASE_IMAGE_CLI    ?= $(BIN)-php-cli:latest
BASE_DOCKERFILE   ?= docker/base/php/Dockerfile
DEV_PATH          ?= docker/dev
DEV_DOCKERFILE    ?= $(DEV_PATH)/php/Dockerfile
IMAGE             ?= $(REGISTRY)/$(BIN)
TAG               ?= $(VERSION)
DEVELOPER_UID     ?= $(shell id -u)


ARG := $(word 2, $(MAKECMDGOALS))
%:
	@:
help:
	@echo -e '\033[1m make [TARGET] \033[0m'
	@grep -E '(^[a-zA-Z0-9_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}{printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'
	@echo && $(MAKE) -s env-info

build: ## Build image
	@docker build -t $(REGISTRY)/$(BASE_IMAGE_CLI)-dev         \
	--build-arg BASE_IMAGE=$(BUILD_IMAGE_CLI)   \
	--build-arg DEVELOPER_UID=$(DEVELOPER_UID)             \
	-f $(DEV_DOCKERFILE) .

up: ## Start the project docker containers
	@cd ./docker && $(COMPOSE) up -d

down: ## Remove the docker containers
	@cd ./docker && $(COMPOSE) down

stop: ## Stop the docker containers
	@cd ./docker && $(COMPOSE) stop

console: ## Enter into application container
	@if [ "${ARG}" = 'root' ] || [ "${ARG}" = 'r' ]; then docker exec -it -u root $(BIN) bash; fi
	@if [ "${ARG}" = '' ] || [ "${ARG}" = 'developer' ]; then docker exec -it $(BIN) bash; fi
