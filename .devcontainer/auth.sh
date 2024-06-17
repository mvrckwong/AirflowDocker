# Source the environment from the current directory.
source .env

# Retrieve the API token
HCP_API_TOKEN=$(curl --location "https://auth.idp.hashicorp.com/oauth2/token" \
--header "Content-Type: application/x-www-form-urlencoded" \
--data-urlencode "client_id=23Rm5yv23bUY50hasxWUo8z39hUBareJ" \
--data-urlencode "client_secret=i8fLpOjqOTaCMGtby-oa039DLqGcpn9l3kbmB1unUvb_5fafXAPMGTxVovkWHz4C" \
--data-urlencode "grant_type=client_credentials" \
--data-urlencode "audience=https://api.hashicorp.cloud" | jq -r .access_token)

# Check if the HCP_API_TOKEN has a value
if [ -n "$HCP_API_TOKEN" ]; then
  echo "HCP_API_TOKEN has value."
else
  echo "HCP_API_TOKEN is empty."
fi

# Fetch and parse the secrets
RESPONSE=$(curl --silent \
  --location "https://api.cloud.hashicorp.com/secrets/2023-06-13/organizations/68da4ae2-5f9a-43aa-8c4e-046da0b3b20b/projects/55184cdf-03ba-42c3-a8e3-9bb96aa0d10c/apps/dev/open" \
  --request GET \
  --header "Authorization: Bearer $HCP_API_TOKEN" | jq -r '.secrets[] | "\(.name) = \(.version.value)"')

# Set and export the environment variables
export AIRFLOW_DB_HOST=$(echo "$RESPONSE" | grep AIRFLOW_DB_HOST | cut -d '=' -f 2-)
export AIRFLOW_DB_USER=$(echo "$RESPONSE" | grep AIRFLOW_DB_USER | cut -d '=' -f 2-)
export AIRFLOW_DB_PW=$(echo "$RESPONSE" | grep AIRFLOW_DB_PW | cut -d '=' -f 2-)
export AIRFLOW_DB_NAME=$(echo "$RESPONSE" | grep AIRFLOW_DB_NAME | cut -d '=' -f 2-)
