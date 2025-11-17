.PHONY: help up down restart logs logs-grafana logs-nginx logs-postgres build clean ps db-connect

help: ## Menampilkan bantuan
	@echo "Grafana + Nginx + PostgreSQL Docker Setup"
	@echo ""
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $1, $2}'

up: ## Menjalankan semua services
	docker-compose up -d
	@echo "✅ Services started!"
	@echo "🐘 PostgreSQL: localhost:5432"
	@echo "📊 Grafana: http://localhost:4000"
	@echo "🌐 Nginx: http://localhost:80"

down: ## Menghentikan semua services
	docker-compose down

restart: ## Restart semua services
	docker-compose restart

logs: ## Melihat logs semua services
	docker-compose logs -f

logs-grafana: ## Melihat logs Grafana
	docker-compose logs -f grafana

logs-nginx: ## Melihat logs Nginx
	docker-compose logs -f nginx

logs-postgres: ## Melihat logs PostgreSQL
	docker-compose logs -f postgres

build: ## Build ulang images
	docker-compose build --no-cache

clean: ## Menghapus containers, volumes, dan images
	docker-compose down -v
	docker-compose rm -f

ps: ## Melihat status containers
	docker-compose ps

db-connect: ## Connect ke PostgreSQL
	docker-compose exec postgres psql -U grafana -d grafana