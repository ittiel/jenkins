
pipelineJob('mini-ci-pipeline') {

    def repo = 'https://github.com/ittiel/jenkins.git'

    triggers {
        scm('* * * * *')
    }
    description("Pipeline for $repo")

    definition {
        cpsScm {
            scm {
                git {
                    remote { url(repo) }
                    branches('master')
                    scriptPath('Jenkinsfile')
                    extensions { }  // required as otherwise it may try to tag the repo, which you may not want
                }

            }
        }
    }
}

// Start the job
//queue('mini-ci')

