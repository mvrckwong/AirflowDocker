# Dockerfile
FROM vault:1.13.3

# Set environment variables for Vault
ENV VAULT_ADDR=http://0.0.0.0:8200
ENV VAULT_API_ADDR=http://0.0.0.0:8200

# Expose the port Vault will run on
EXPOSE 8200

# Entry point for the Vault server
ENTRYPOINT ["vault", "server", "-config=/vault/config/vault-config.json"]
