#!/bin/bash

# Setup Caddy Reverse proxy
# Usage: setup-caddy.sh

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Env variable '\$Domain' not provided."
    exit 1
fi

echo "Setting up Caddy for domain: $DOMAIN"

sudo mkdir -p /etc/caddy
# TODO: Remove the acme_ca block for production
cat << EOF > /etc/caddy/Caddyfile
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF

# Start Caddy service
sudo systemctl restart caddy
sudo systemctl enable caddy

echo "Caddy setup complete. Please check if the service is running."
