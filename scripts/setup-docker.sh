#!/bin/bash

# Setup Docker configuration
# Usage: setup-docker.sh

# Setup Docker permissions to Jenkins 
sudo usermod -a -G docker jenkins

# Start Docker
sudo systemctl start docker

# Setup multi-arch support
docker run --privileged --rm tonistiigi/binfmt --install all

# Enable Docker
sudo systemctl enable docker

echo "Docker setup complete."
