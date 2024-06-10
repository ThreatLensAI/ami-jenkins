multibranchPipelineJob('static-site-pr') {
  branchSources {
    branchSource {
      source {
        github {
          id('static-site')
          credentialsId('github')
          repoOwner('csye7125-su24-team06')
          repository('static-site')
          configuredByUrl(false)
          repositoryUrl('')
          traits {
            gitHubNotificationContextTrait {
              contextLabel('jenkins/pr-validate')
              typeSuffix(false)
            }
            gitHubPullRequestDiscovery {
              strategyId(3)
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
