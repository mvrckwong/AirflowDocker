run_airflow_init:
	docker compose -f "docker-compose.yml" down
	docker compose -f "docker-compose.yml" up -d --build --profile init up

run_airflow_debug:
	docker compose -f "docker-compose.yml" down
	docker compose -f "docker-compose.yml" up -d --build --profile debug up

run_airflow:
	docker compose -f "docker-compose.yml" down
	docker compose -f "docker-compose.yml" up -d --build

reload_reqs:
	poetry export -f requirements.txt --output ./.devcontainer/requirements.txt --without-hashes