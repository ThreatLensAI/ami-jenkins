multibranchPipelineJob('static-site-pr') {
  branchSources {
    github {
      id('static-site')
      scanCredentialsId('github')
      repoOwner('csye7125-su24-team06')
      repository('static-site')
      traits {
        githubNotificationContextTrait {
          context('jenkins/pr-validate')
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
      daysToKeep(-1)
    }
  }
}
