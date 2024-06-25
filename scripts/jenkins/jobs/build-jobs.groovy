// Repository Owner
String buildJobRepoOwner = 'csye7125-su24-team06'

// List of repositories to create build jobs for
def buildRepos = [
  'static-site',
  'helm-webapp-cve-processor',
  'webapp-cve-processor',
  'helm-chart-caddy',
  'webapp-cve-consumer',
  'db-migration',
  'helm-webapp-cve-consumer'
]

// Pull Request Job
String buildScriptPath = 'Jenkinsfile'

for (buildRepo in buildRepos) {
  String url = "${buildJobRepoOwner}/${buildRepo}".toString()
  pipelineJob(buildRepo) {
    definition {
      cpsScm {
        lightweight(true)
        scm {
          git {
            branch("main")
            remote {
              github(url)
              credentials('github-app')
            }
            extensions {
              wipeOutWorkspace()
              localBranch()
            }
          }
        }
        scriptPath(buildScriptPath)
      }
    }
    triggers {
      githubPush()
    }
  }
}
