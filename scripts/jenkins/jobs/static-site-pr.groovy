multibranchPipelineJob('static-site-pr') {
  branchSources {
    branchSource {
      source {
        github {
          id('static-site')
          credentialsId('github')
          repoOwner('csye7125-su24-team06')
          repository('static-site')
          repositoryUrl('')
          configuredByUrl(false)
          traits {
            gitHubNotificationContextTrait {
              contextLabel('jenkins/pr-validate')
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
                  value('+refs/heads/main:refs/remotes/@{remote}/main')
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
      scriptPath('Jenkinsfile.pr')
    }
  }

  orphanedItemStrategy {
    discardOldItems {
      numToKeep(-1)
      daysToKeep(30)
    }
  }
}
