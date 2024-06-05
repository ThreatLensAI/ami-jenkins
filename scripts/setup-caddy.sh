#!/bin/bash

# Setup Caddy Reverse proxy
# Usage: setup-caddy.sh

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Env variable '\$DOMAIN' not provided."
    exit 1
fi

if [ -z "$EMAIL" ]; then
    echo "Env variable '\$EMAIL' not provided."
    exit 1
fi

# Stop Caddy Service
sudo systemctl stop caddy

echo "Setting up Caddy for domain: $DOMAIN with email: $EMAIL"

sudo mkdir -p /etc/caddy

if [[ $ENVIRONMENT = "PRODUCTION" ]]; then
cat << EOF > /etc/caddy/Caddyfile
{
    email $EMAIL
}
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF
else
cat << EOF > /etc/caddy/Caddyfile
{
    acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
    email $EMAIL
}
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF
fi

# Enable Caddy service
sudo systemctl enable caddy

echo "Caddy setup complete."
