import jenkins.model.*
import hudson.security.*
import jenkins.install.InstallState

def env = System.getenv()

def jenkins = Jenkins.getInstance()
jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))
jenkins.setAuthorizationStrategy(new GlobalMatrixAuthorizationStrategy())

def user = jenkins.getSecurityRealm().createAccount(env.JENKINS_USER, env.JENKINS_PASS)
user.save()

jenkins.getAuthorizationStrategy().add(Jenkins.ADMINISTER, env.JENKINS_USER)

if (!jenkins.installState.isSetupComplete()) {
  println '--> Skip SetupWizard'
  InstallState.INITIAL_SETUP_COMPLETED.initializeState()
}

jenkins.save()
