#!/bin/bash

# Setup Caddy Reverse proxy
# Usage: setup-caddy.sh

# Check if domain is provided
if [ -z "$DOMAIN" ]; then
    echo "Env variable '\$Domain' not provided."
    exit 1
fi

echo "Setting up Caddy for domain: $DOMAIN"

# TODO: Remove this
sudo ufw allow ssh

# Set up firewall # TODO: Check if ufw is needed?
sudo ufw allow proto tcp from any to any port 80,443
sudo ufw --force enable

# TODO: Need to create new user `caddy` and assign permissions??

sudo mkdir -p /etc/caddy

# TODO: Remove the acme_ca block for production
cat << EOF > /etc/caddy/Caddyfile
{
    acme_ca https://acme-staging-v02.api.letsencrypt.org/directory
}
$DOMAIN {
    reverse_proxy localhost:8080
}
EOF

sudo systemctl restart caddy

echo "Caddy setup complete. Please check if the service is running."
