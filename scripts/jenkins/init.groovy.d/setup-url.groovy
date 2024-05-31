/*
 * Setup jenkins URL and admin email address.
 */
import jenkins.model.Jenkins
import jenkins.model.JenkinsLocationConfiguration
import groovy.net.URLBuilder

def email = System.getenv("EMAIL")
def domain = System.getenv("DOMAIN")

assert email != null : "No EMAIL env var provided, but required"
assert domain != null : "No DOMAIN env var provided, but required"

// Construct the URL using URLBuilder
def urlBuilder = new URLBuilder()
urlBuilder.scheme = 'https'
urlBuilder.host = domain
def url = urlBuilder.toString()
if (!url.endsWith("/")) {
    url += "/"
}

// get Jenkins location configuration
def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()

// set Jenkins URL
jenkinsLocationConfiguration.setUrl(url)

// set Jenkins admin email address
jenkinsLocationConfiguration.setAdminAddress(email)

// save current Jenkins state to disk
jenkinsLocationConfiguration.save()
