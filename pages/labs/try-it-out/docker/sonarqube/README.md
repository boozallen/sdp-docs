# pecos-sonarqube
This repository builds a fully configured image of Sonarqube.

### Installing
 1. A secret named `sonarqube-db-secrets` must exist in the project. It must contain the following keys:
      1. `database-name` - should be `sonar`. Consider hardcoding this in the yaml file in the future.
      1. `database-user` - The username in the db for sonar to use
      1. `database-password` - The password in the db for sonar to use
 1. `oc create -f sonarqube.yaml`
 1. Wait ~20s
 1. `oc create -f job.yaml`

### Nutrition Facts
 1. Plugins
     1. FindBugs
     1. SonarJava
     1. CheckStyle
     1. PMD
     1. SonarJS
 1. API Token
     1. Generate an API token
     1. Put that API token in the Jenkins credentials store, specifically the one named `sonarqube`
     1. Also put that API token at "Manage Jenkins > Configure System > SonarQube servers > Server authentication token"
 1. WebHook
     1. Create a webhook named `Jenkins` with the value `http://jenkins.apps.nonprod.pecoscms.net/sonarqube-webhook/`
 i Note that that url is just the jenkins route plus "/sonarqube-webhook/"
 
 ### Components
 Each piece of the repo and how it should be used
 
 ##### Jenkinsfile
 Interpreted by jenkins in order to build the image and push to the docker repository
 
 ##### Dockerfile
 Base image plus Sonar and plugins download
 
 ##### docker-entrypoint.sh
 Installs/moves the plugins, and then starts Sonarqube Server. This needed to be at runtime due to PV configuration in the base image. Once we update the base image, this can probably be moved to the Dockerfile.
 
 ##### sonarqube.yaml
 Sets up an instance of this Sonarqube, along with a basic postgres instance
 
 What it does:
  * Creates Sonar and postgres pods, services, and route

 ##### job.yaml
 Creates a job to finish setting up sonarqube
 
 What it does:
  * Adds a config file for the Jenkins Sonarqube plugin
  * Creates a user token in Sonarqube
  * Store that user token in the Jenkins credential store
  * Add a webhook for Jenkins in Sonarqube
