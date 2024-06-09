pipelineJob('static-site-pr') {
    description('CSYE7125 Static Site hosted with Caddy')
    definition {
        cpsScm {
            lightweight(true)
            scm {
                git {
                    branch('main')
                    remote {
                        github('csye7125-su24-team06/static-site')
                        credentials('github')
                    }
                }
            }
            scriptPath('Jenkinsfile-PR')
        }
    }
    triggers {
        githubPush()
    }
}
