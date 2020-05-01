include .env

.PHONY: help docker-pull docker-up docker-stop docker-down docker-prune docker-shell-web docker-shell-web-cmd docker-drush docker-site-install docker-site-update docker-contrib-update

default: help

help:  ## Display this help.
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

project-init: ## Launch init script.
	@echo "$(COLOR_LIGHT_GREEN)Launch init.sh script...$(COLOR_NC)"
	./scripts/init.sh

docker-pull: ## Update container images.
	@echo "$(COLOR_LIGHT_GREEN)Update containers images for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose pull

docker-up: ## Start containers.
	@echo "$(COLOR_LIGHT_GREEN)Starting up containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose up -d

docker-stop: ## Stop containers.
	@echo "$(COLOR_LIGHT_GREEN)Stopping containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose stop

docker-down: ## Remove containers.
	@echo "$(COLOR_LIGHT_GREEN)Removing containers for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose down

docker-prune: ## Remove containers, volumes and images.
	@echo "$(COLOR_LIGHT_GREEN)Removing containers, volumes and images for $(PROJECT_NAME)...$(COLOR_NC)"
	@docker-compose down -v --rmi all

docker-shell-web: ## Open a command line in the web container.
	@docker-compose exec -e LINES=$(tput lines) -e COLUMNS=$(tput cols) web bash

docker-shell-web-cmd: ## Execute the entered command. Example: make docker-shell-web-cmd "ls -l"
	@docker-compose exec web bash -c "$(filter-out $@,$(MAKECMDGOALS))"

docker-drush: ## Execute the entered Drush command. Example: make docker-drush cr
	@docker-compose exec web bash -c "$(DRUSH) $(filter-out $@,$(MAKECMDGOALS))"

docker-site-install: ## Install Drupal website.
	@docker-compose exec web bash -c "cd $(PROJECT_PATH) && ./scripts/install.sh"

docker-site-update: ## Update Drupal website.
	@docker-compose exec web bash -c "cd $(PROJECT_PATH) && ./scripts/update.sh"

docker-contrib-update: ## Update contrib.
	@docker-compose exec web bash -c "cd $(PROJECT_PATH) && ./scripts/contrib-update.sh"

# https://stackoverflow.com/a/6273809/1826109
%:
	@:
