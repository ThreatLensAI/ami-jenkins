#!/bin/bash

# Setup Docker configuration
# Usage: setup-docker.sh

# Setup Docker permissions to Jenkins 
sudo usermod -a -G docker jenkins

# Setup multi-arch support
docker run --privileged --rm tonistiigi/binfmt --install all

# Start Docker
sudo systemctl restart docker

echo "Docker setup complete."
