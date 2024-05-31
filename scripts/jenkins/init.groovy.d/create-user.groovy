/*
 * Create an admin user.
 */
import jenkins.model.*
import hudson.security.*

// Get admin user and password from environment variables
def adminUsername = System.getenv("JENKINS_USER")
def adminPassword = System.getenv("JENKINS_PASSWORD")
assert adminPassword != null : "No JENKINS_USER env var provided, but required"
assert adminPassword != null : "No JENKINS_PASSWORD env var provided, but required"

// Updating login authorization strategy
def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)

// Create admin user
def hudsonRealm = new HudsonPrivateSecurityRealm(false)
hudsonRealm.createAccount(adminUsername, adminPassword)

// Set security realm and authorization strategy
Jenkins.instance.setSecurityRealm(hudsonRealm)
Jenkins.instance.setAuthorizationStrategy(strategy)

// Save settings
Jenkins.instance.save()
