run_airflow:
	docker compose -f "docker-compose.yaml" down
	docker compose -f "docker-compose.yaml" up -d --build --profile init up

run_airflow_debug:
	docker compose -f "docker-compose.yaml" down
	docker compose -f "docker-compose.yaml" up -d --build --profile debug up

run_airflow_users:
	docker compose -f "docker-compose.users.yaml" down
	docker compose -f "docker-compose.yaml" up -d --build

reload_reqs:
	poetry export -f requirements.txt --output ./.devcontainer/requirements.txt --without-hashes