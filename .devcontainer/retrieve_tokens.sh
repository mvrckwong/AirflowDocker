#!/bin/sh

# Source the environment from the current directory.
source .env

# Retrieve the API token
HCP_API_TOKEN=$(curl --location "https://auth.idp.hashicorp.com/oauth2/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=$HCP_CLIENT_ID" \
--data-urlencode "client_secret=$HCP_CLIENT_SECRET" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "audience=https://api.hashicorp.cloud" | jq -r .access_token)

# Check if the HCP_API_TOKEN has a value
if [ -n "$HCP_API_TOKEN" ]; then
  echo "HCP_API_TOKEN has value."
else
  echo "HCP_API_TOKEN is empty."
fi

# Fetch and parse the secrets
response=$(curl --silent \
  --location "https://api.cloud.hashicorp.com/secrets/2023-06-13/organizations/68da4ae2-5f9a-43aa-8c4e-046da0b3b20b/projects/55184cdf-03ba-42c3-a8e3-9bb96aa0d10c/apps/dev/open" \
  --request GET \
  --header "Authorization: Bearer $HCP_API_TOKEN" | jq -r '.secrets[] | "\(.name)=\(.version.value)"')

# Parse the response and assign to environment variables
for line in $response; do
  export $line
done