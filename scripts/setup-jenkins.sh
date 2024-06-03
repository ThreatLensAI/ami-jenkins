#!/bin/bash

# Setup Jenkins Server
# Usage: setup-jenkins.sh

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

# Install Plugins
sudo java -jar jenkins-plugin-manager-2.13.0.jar --war /usr/share/java/jenkins.war \
--plugin-download-directory /var/lib/jenkins/plugins \
--plugin-file /tmp/plugins.txt

echo "Jenkins Plugins Installed."

echo "Setting up Jenkins env..."
# Disable Jenkins initial setup wizard and set admin credentials
sudo mkdir -p /etc/systemd/system/jenkins.service.d/
cat << EOF > /etc/systemd/system/jenkins.service.d/override.conf
[Service]
Environment="JAVA_OPTS=-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false"
Environment="JENKINS_USER=$JENKINS_USER"
Environment="JENKINS_PASSWORD=$JENKINS_PASSWORD"
Environment="EMAIL=$EMAIL"
Environment="DOMAIN=$DOMAIN"
EOF

# Copying Init Groovy scripts
sudo cp -r /tmp/init.groovy.d/ /var/lib/jenkins/

# Change ownership of plugins, init.groovy.d directory
sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins
sudo chown -R jenkins:jenkins /var/lib/jenkins/init.groovy.d

echo "Jenkins env setup complete."

echo "Reloading systemd & starting Jenkins service..."
# Reload systemd & start Jenkins service
sudo systemctl daemon-reload
sudo systemctl start jenkins

echo "Jenkins setup complete."
