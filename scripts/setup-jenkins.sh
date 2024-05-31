#!/bin/bash

wget -q https://github.com/jenkinsci/plugin-installation-manager-tool/releases/download/2.13.0/jenkins-plugin-manager-2.13.0.jar

sudo java -jar jenkins-plugin-manager-2.13.0.jar --war /usr/share/java/jenkins.war \
--plugin-download-directory /var/lib/jenkins/plugins \
--plugin-file /tmp/plugins.txt

sudo chown -R jenkins:jenkins /var/lib/jenkins/plugins

sudo systemctl start jenkins
