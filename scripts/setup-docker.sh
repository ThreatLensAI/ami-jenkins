#!/bin/bash

# Setup Docker configuration
# Usage: setup-docker.sh

# Setup multi-arch support
docker run --privileged --rm tonistiigi/binfmt --install all

# Setup Docker permissions to Jenkins 
sudo usermod -a -G docker jenkins
chmod 666 /var/run/docker.sock

# Start Docker
sudo systemctl start docker

echo "Docker setup complete."
