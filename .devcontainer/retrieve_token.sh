#!/bin/sh

# Retrieve the API token
HCP_API_TOKEN=$(curl --location "https://auth.idp.hashicorp.com/oauth2/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=$HCP_CLIENT_ID" \
--data-urlencode "client_secret=$HCP_CLIENT_SECRET" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "audience=https://api.hashicorp.cloud" | jq -r .access_token)

# Run the main script or command (replace with your actual command)
echo "Starting Airflow with API token..."
echo "HCP_API_TOKEN: $HCP_API_TOKEN"

# Start Airflow services
exec "$@"