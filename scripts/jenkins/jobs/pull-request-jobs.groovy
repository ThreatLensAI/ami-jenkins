// Repository Owner
String pullRequestRepoOwner = 'csye7125-su24-team06'

// List of repositories to create pull request jobs for
def pullRequestRepos = ['static-site']

// Pull Request Job
String pullRequestScriptPath = 'Jenkinsfile.pr'

// Create pull request jobs
for (pullRequestRepo in pullRequestRepos) {
  String prJobName = "${pullRequestRepo}-pr".toString()
  multibranchPipelineJob(prJobName) {
    branchSources {
      branchSource {
        source {
          github {
            id(prJobName)
            credentialsId('github')
            repoOwner(pullRequestRepoOwner)
            repository(pullRequestRepo)
            repositoryUrl("")
            configuredByUrl(false)
            traits {
              gitHubNotificationContextTrait {
                contextLabel("jenkins/pr-validate")
                typeSuffix(true)
              }
              gitHubIgnoreDraftPullRequestFilter()
              gitHubForkDiscovery {
                strategyId(3)
                trust {
                  gitHubTrustPermissions()
                }
              }
              gitHubPullRequestDiscovery {
                strategyId(3)
              }
              refSpecs {
                templates {
                  refSpecTemplate {
                    value("+refs/heads/main:refs/remotes/@{remote}/main")
                  }
                }
              }
            }
          }
        }
      }
    }

    factory {
      workflowBranchProjectFactory {
        scriptPath(pullRequestScriptPath)
      }
    }
  
    orphanedItemStrategy {
      discardOldItems {
        numToKeep(-1)
        daysToKeep(30)
      }
    }
  }
}
