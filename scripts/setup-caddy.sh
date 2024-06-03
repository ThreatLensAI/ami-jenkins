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

echo "Setting up Caddy for domain: $DOMAIN with email: $EMAIL"

sudo mkdir -p /etc/caddy
cat << EOF > /etc/caddy/Caddyfile
{
    # acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
    email $EMAIL
}
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF

# Start Caddy service
sudo systemctl restart caddy
sudo systemctl enable caddy

echo "Caddy setup complete."
