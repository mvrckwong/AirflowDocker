#!/bin/sh

# Retrieve the API token
HCP_API_TOKEN=$(curl --location "https://auth.idp.hashicorp.com/oauth2/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=1lHczZGZEsVjRsRaYWI2Z9Vqt3zHPulD" \
--data-urlencode "client_secret=sqX1PvI5zgVqRbUxZ_GIlWpDuhuviSd3w-xRE5zvB3FiVfGADb-my1X0XfogKOMn" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "audience=https://api.hashicorp.cloud" | jq -r .access_token)

# Run the main script or command (replace with your actual command)
echo "Starting Airflow with API token..."
echo "HCP_API_TOKEN: $HCP_API_TOKEN"

# Get the database credentials
AIRFLOW_DB_USER=$(curl -s --header 'X-Vault-Token: root' --request GET http://vault:8200/v1/secret/data/database | jq -r '.data.data.AIRFLOW_DB_USER');
AIRFLOW_DB_PW=$(curl -s --header 'X-Vault-Token: root' --request GET http://vault:8200/v1/secret/data/database | jq -r '.data.data.AIRFLOW_DB_PW');
AIRFLOW_DB_NAME=$(curl -s --header 'X-Vault-Token: root' --request GET http://vault:8200/v1/secret/data/database | jq -r '.data.data.AIRFLOW_DB_NAME');
AIRFLOW_DB_HOST=$(curl -s --header 'X-Vault-Token: root' --request GET http://vault:8200/v1/secret/data/database | jq -r '.data.data.AIRFLOW_DB_HOST');

# Export the credentials
export AIRFLOW_DB_USER AIRFLOW_DB_PW AIRFLOW_DB_NAME AIRFLOW_DB_HOST;

# Start Airflow services
exec "$@"