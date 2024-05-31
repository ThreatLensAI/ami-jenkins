#!/bin/bash

# Installs Jenkins server in the machine
# Usage: install-jenkins.sh

# Check if sudo is available
if ! sudo -v >/dev/null 2>&1; then
   echo "Installation requires sudo permissions" 
   exit 1
fi

echo "Installing Jenkins"

# Adding Jenkins apt repository key & entry
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

# Install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins=2.452.1

# Enable Jenkins service
sudo systemctl stop jenkins
sudo systemctl enable jenkins

echo "Jenkins installation complete"
