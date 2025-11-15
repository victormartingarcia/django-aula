.PHONY: help build start serve stop down load_demo_data

# Aesthetics
YELLOW := "\e[1;33m"
NC := "\e[0m"

# Shell Functions
INFO := @bash -c '\
  printf $(YELLOW); \
  echo "=> $$1"; \
  printf $(NC)' SOME_VALUE

# Default target - show help
help:
	@printf $(YELLOW)
	@echo "╔════════════════════════════════════════════════════════════╗"
	@echo "║                   Available Commands                       ║"
	@echo "╚════════════════════════════════════════════════════════════╝"
	@printf $(NC)
	@echo ""
	@printf $(YELLOW)
	@echo "Service Management:"
	@printf $(NC)
	@echo "  make build          Rebuild Docker web service image from scratch"
	@echo "  make start          Run services in foreground (with logs visible)"
	@echo "  make serve          Run services in background (detached mode)"
	@echo "  make stop           Stop running services (preserves containers)"
	@echo "  make down           Stop services and remove containers/database"
	@echo ""
	@printf $(YELLOW)
	@echo "Data Management:"
	@printf $(NC)
	@echo "  make load_demo_data Load demo/fixture data (requires services running)"
	@echo ""
	@printf $(YELLOW)
	@echo "Help:"
	@printf $(NC)
	@echo "  make help           Show this help message"
	@echo ""

# Service Management
build:
	${INFO} "Creating builder image..."
	@ docker-compose build --no-cache web
	${INFO} "Build completed"

start:
	${INFO} "Running services"
	@ docker-compose up

serve:
	${INFO} "Running services"
	@ docker-compose up -d

stop:
	${INFO} "Stoping services"
	@ docker-compose stop

down:
	${INFO} "Stoping services and deleting the db"
	@ docker-compose down

load_demo_data:
	${INFO} "Load demo data"
	@ docker-compose exec web python manage.py loaddata aula/apps/*/fixtures/dades.json
	@ docker-compose exec web python manage.py collectstatic --noinput
	@ docker-compose exec web python manage.py loaddemodata