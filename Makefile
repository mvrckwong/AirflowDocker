restart_airflow_docker:
	docker compose -f "docker-compose.yaml" down
	docker compose -f "docker-compose.yaml" up -d --build