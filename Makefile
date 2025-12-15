COMPOSE := docker compose -f docker-compose.dev.yml
RAILS := ./bin/rails

.PHONY: help setup deps build up down restart logs ps console rconsole db_prepare db_migrate db_seed test server css_watch shell

help:
	@echo "Usage: make <target>"
	@echo "  setup        Install gems and prepare DB"
	@echo "  deps         Install gems (bundle install)"
	@echo "  build        Build docker images"
	@echo "  up           Start services (detached)"
	@echo "  down         Stop and remove containers"
	@echo "  restart      Restart services"
	@echo "  logs         Show docker-compose logs (follow)"
	@echo "  ps           Show docker-compose ps"
	@echo "  console      Open rails console on running web container"
	@echo "  rconsole     Run a one-off web container and open rails console"
	@echo "  db_prepare   Create and migrate DB (db:prepare)"
	@echo "  db_test_setup Prepare test DB (set env and load schema)"
	@echo "  db_migrate   Run migrations"
	@echo "  db_seed      Run seeds"
	@echo "  db_reset     Reset DB (db:reset)"
	@echo "  test         Run test suite inside web container"
	@echo "  server       Start rails server (inside running web container)"
	@echo "  css_watch    Tailwind CSS watcher (css service)"
	@echo "  shell        Open a shell in the web container"

# Local setup targets
setup: deps db_prepare

deps:
	bundle install

# Docker related targets
build:
	$(COMPOSE) build --pull

up:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

# Rails / app targets (use exec when web is running)
console:
	$(COMPOSE) exec web $(RAILS) console

rconsole:
	$(COMPOSE) run --rm web $(RAILS) console

db_prepare:
	$(COMPOSE) exec web $(RAILS) db:prepare

db_test_setup:
	# Ensure test environment is set and schema is loaded for tests
	$(COMPOSE) run --rm -e RAILS_ENV=test web $(RAILS) db:environment:set RAILS_ENV=test
	$(COMPOSE) run --rm -e RAILS_ENV=test web $(RAILS) db:schema:load RAILS_ENV=test

db_migrate:
	$(COMPOSE) exec web $(RAILS) db:migrate

db_seed:
	$(COMPOSE) exec web $(RAILS) db:seed

db_reset:
	$(COMPOSE) exec web $(RAILS) db:reset

test:
	$(COMPOSE) exec web $(RAILS) test

server:
	$(COMPOSE) exec web $(RAILS) server -b 0.0.0.0 -p 3000

css_watch:
	$(COMPOSE) exec css $(RAILS) tailwindcss:watch

shell:
	$(COMPOSE) exec web /bin/bash

set_env:
	$(COMPOSE) exec web $(RAILS) db:environment:set RAILS_ENV=development