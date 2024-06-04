#!/bin/bash

# Installs dependencies for the application
# Usage: install-dependencies.sh

# Check if sudo is available
if ! sudo -v >/dev/null 2>&1; then
   echo "Installation requires sudo permissions" 
   exit 1
fi

echo "Installing dependencies"

# Update the system
sudo apt-get -y upgrade

# Install Fontconfig, Java
sudo apt-get install -y fontconfig openjdk-17-jre

echo "Dependencies installation complete."
