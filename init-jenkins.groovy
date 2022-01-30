import jenkins.model.*
import hudson.security.*

import javaposse.jobdsl.dsl.DslScriptLoader
import javaposse.jobdsl.plugin.JenkinsJobManagement


// Setup security


def env = System.getenv()

def jenkins = Jenkins.getInstance()
//jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))
//jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

//def user = jenkins.getSecurityRealm().createAccount(env.JENKINS_USER, env.JENKINS_PASS)
//user.save()

//jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, env.JENKINS_USER)
//jenkins.save()


// Setup number of executors
Jenkins.instance.setNumExecutors(11)


// Create initial jobs
def jobDslScript = new File('/tmp/jobs.groovy')
def workspace = new File('/tmp')
def jobManagement = new JenkinsJobManagement(System.out, [:], workspace)


// Run the jobs to create some test results
new DslScriptLoader(jobManagement).runScript(jobDslScript.text)
