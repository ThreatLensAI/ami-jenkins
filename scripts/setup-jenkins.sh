#!/bin/bash

# Setup Jenkins Server
# Usage: setup-jenkins.sh

# Stop Jenkins service
sudo systemctl stop jenkins

# Check if domain is provided
if [ -z "$JENKINS_USER" ]; then
    echo "Env variable '\$JENKINS_USER' not provided."
    exit 1
fi

if [ -z "$JENKINS_PASSWORD" ]; then
    echo "Env variable '\$JENKINS_PASSWORD' not provided."
    exit 1
fi

# Get Jenkins Plugin Installation Manager
wget -q https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar

echo "Installing Jenkins Plugins..."

# Create Jenkins jcasc config directory
sudo mkdir -p /var/lib/jenkins/casc_configs/
sudo cp -r /tmp/jenkins/* /var/lib/jenkins/casc_configs/

# Change ownership of jcasc config directory
sudo chown -R jenkins:jenkins /var/lib/jenkins/casc_configs

# Install Plugins
sudo java -jar jenkins-plugin-manager-2.13.0.jar --war /usr/share/java/jenkins.war \
--plugin-download-directory /var/lib/jenkins/plugins \
--plugin-file /var/lib/jenkins/casc_configs/plugins.txt

echo "Jenkins Plugins Installed."

echo "Setting up Jenkins env..."
# Disable Jenkins initial setup wizard and set admin credentials
sudo mkdir -p /etc/systemd/system/jenkins.service.d/
cat << EOF > /etc/systemd/system/jenkins.service.d/override.conf
[Service]
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"
Environment="CASC_JENKINS_CONFIG=/var/lib/jenkins/casc_configs"
Environment="EMAIL=$EMAIL"
Environment="DOMAIN=$DOMAIN"
Environment="SECRETS_FILE=/var/lib/jenkins/secrets/jcasc.properties"
EOF

sudo mkdir -p /var/lib/jenkins/secrets
cat << EOF > /var/lib/jenkins/secrets/jcasc.properties
JENKINS_USER=$JENKINS_USER
JENKINS_PASSWORD=$JENKINS_PASSWORD
DOCKER_HUB_USERNAME=$DOCKER_HUB_USERNAME
DOCKER_HUB_PASSWORD=$DOCKER_HUB_PASSWORD
GITHUB_TOKEN=$GITHUB_TOKEN
EOF

# Change ownership of plugins, init.groovy.d directory
sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins
sudo chown -R jenkins:jenkins /var/lib/jenkins/secrets/jcasc.properties
sudo chmod 600 /var/lib/jenkins/secrets/jcasc.properties

echo "Jenkins env setup complete."

echo "Reloading systemd & starting Jenkins service..."
# Reload systemd & enable Jenkins service
sudo systemctl daemon-reload
sudo systemctl enable jenkins

echo "Jenkins setup complete."
