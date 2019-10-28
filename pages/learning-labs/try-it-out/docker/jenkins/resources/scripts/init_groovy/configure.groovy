/*
Copyright © 2018 Booz Allen Hamilton. All Rights Reserved.
This software package is licensed under the Booz Allen Public License. The license can be found in the License file or at http://boozallen.github.io/licenses/bapl
*/

import jenkins.*
import hudson.*
import hudson.util.Secret
import hudson.model.*
import jenkins.model.*
import hudson.security.*
import jenkins.security.*
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.impl.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import com.cloudbees.plugins.credentials.CredentialsProvider
import hudson.plugins.sshslaves.*
import org.openshift.jenkins.plugins.openshiftlogin.OpenShiftOAuth2SecurityRealm
import groovy.io.FileType
import javaposse.jobdsl.dsl.DslScriptLoader
import javaposse.jobdsl.plugin.JenkinsJobManagement
import java.util.logging.Logger
import org.jenkinsci.plugins.github_branch_source.GitHubConfiguration
import org.jenkinsci.plugins.github_branch_source.Endpoint

// for shared libraries
import org.jenkinsci.plugins.workflow.libs.GlobalLibraries
import org.jenkinsci.plugins.workflow.libs.LibraryConfiguration
import org.jenkinsci.plugins.workflow.libs.SCMSourceRetriever
import org.jenkinsci.plugins.workflow.libs.SCMRetriever
import org.jenkinsci.plugins.github_branch_source.GitHubSCMSource
import hudson.plugins.filesystem_scm.FSSCM

// for security
import jenkins.security.s2m.AdminWhitelistRule
import hudson.security.csrf.DefaultCrumbIssuer
import org.jenkinsci.plugins.configfiles.groovy.GroovyScript
import org.jenkinsci.plugins.configfiles.GlobalConfigFiles
import org.jenkinsci.plugins.scriptsecurity.scripts.languages.GroovyLanguage
import jenkins.model.JenkinsLocationConfiguration
import org.jenkinsci.plugins.workflow.flow.FlowDurabilityHint

//for sonar installation
import hudson.plugins.sonar.SonarInstallation
import hudson.plugins.sonar.SonarRunnerInstallation
import hudson.plugins.sonar.SonarRunnerInstaller
import hudson.plugins.sonar.model.TriggersConfig
import hudson.tools.InstallSourceProperty


Credentials sonarqubeCred = (Credentials) new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL, // Scope
  "sonarqube", // id
  "sonarqube", // description
  "admin", // username
  "admin" // password
)

SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), sonarqubeCred)

Credentials dockerCred = (Credentials) new UsernamePasswordCredentialsImpl(
  CredentialsScope.GLOBAL, // Scope
  "sdp-docker-registry", // id
  "sdp-docker-registry", // description
  "unused", // username
  "unused" // password
)

SystemCredentialsProvider.getInstance().getStore().addCredentials(Domain.global(), dockerCred)

// create jobs defined by JobDSL Scripts
def job_dsl = new File("${System.getenv("JENKINS_HOME")}/init.jobdsl.d")
def jobManagement = new JenkinsJobManagement(System.out, [:], new File("."))
job_dsl.eachFileRecurse (FileType.FILES) { script ->
  try{
  	new DslScriptLoader(jobManagement).runScript(script.text)
  }catch(any){
    log "  ERROR: ${any}"
  }
}



// Setup the configuration within Jenkins to be be able to communicate with the SonarQube instance
String sonarqubeURL = "http://sdp-sonarqube:9000"
def sonar = Jenkins.getInstance().getDescriptor("hudson.plugins.sonar.SonarGlobalConfiguration")
def inst = new SonarInstallation(
  "SonarQube",
  sonarqubeURL,
  "", 
  "5.3",
  "",
  new TriggersConfig(),
  ""
)

sonar.setInstallations(inst)


// wait for SonarQube to be ready
String healthCheckPath = "/api/system/health" 
String result = "init" 
while (!result.contains("GREEN")){
  try{
    println "Waiting for SonarQube to be ready.." 
    healthUrl = new URL(sonarqubeURL + healthCheckPath)
    connection = healthUrl.openConnection()
    connection.setRequestMethod("GET")
    connection.doOutput = true 
    authString = "admin:admin".getBytes().encodeBase64().toString()
    connection.setRequestProperty ("Authorization", 'Basic YWRtaW46YWRtaW4=');
    writer = new OutputStreamWriter(connection.outputStream)
    writer.flush()
    writer.close()
    connection.connect()
    result = connection.content.text
    println "   health check returned: ${result}"
  }catch(any){
    println "exception thrown: "
    println any 
  }
  sleep 5000
}

println "SonarQube is Ready!"

// Create the Jenkins webhook within Sonarqube to communicate to Jenkins that analysis was completed

String responseCode = "-1" 

while (!responseCode.contains("204")){
    try{
  
      String webhook = "http://sdp-jenkins:8080/sonarqube-webhook/"
      String webhookPath = '/api/settings/set'
      def url = new URL(sonarqubeURL + webhookPath)
      String encodedValues = java.net.URLEncoder.encode("{\"name\":\"Jenkins\",\"url\":\"$webhook\"}", "UTF-8")
      String urlParameters  = "key=sonar.webhooks.global&fieldValues=$encodedValues";
      connection = url.openConnection()
      connection.setRequestMethod("POST")
      connection.doOutput = true
      def authString = "admin:admin".getBytes().encodeBase64().toString()
      connection.setRequestProperty ("Authorization", 'Basic YWRtaW46YWRtaW4=');
      def writer = new OutputStreamWriter(connection.outputStream)
      writer.flush()
      writer.write(urlParameters.toCharArray())
      writer.close()
      connection.connect()

      responseCode = connection.getResponseCode()
      println "post request for webhook returned: ${responseCode}"

    }catch(any){
    println "exception thrown: "
    println any 
    }
    sleep 5000
}

println "SonarQube has been fully configured!"