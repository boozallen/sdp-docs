libraryRepo = "https://github.com/boozallen/sdp-libraries.git"
libraryRepoCredId = "github"
pipelineConfigRepo = "https://github.com/boozallen/sdp-labs-sample-app.git"
pipelineConfigRepoCredId = "github"
configBaseDir = ""

multibranchPipelineJob('sample-spring-boot-api') {
  branchSources {
    git {
      remote('https://github.com/boozallen/sdp-labs-sample-app')
    }
  }


  configure{
    it.remove(it / factory)

    it / factory(class: "org.boozallen.plugins.jte.job.TemplateBranchProjectFactory", plugin: "jte") {
      owner(class: "org.jenkinsci.plugins.workflow.multibranch.WorkflowMultiBranchProject", reference: "../..")
      scriptPath('Jenkinsfile')

    }

    def job_properties = it / 'properties'


    job_properties << 'org.jenkinsci.plugins.pipeline.modeldefinition.config.FolderConfig'(plugin: 'pipeline-model-definition@1.3.4'){
      dockerLabel ""
      registry(plugin: 'docker-commons@1.13')
    }

    job_properties << 'org.boozallen.plugins.jte.config.TemplateConfigFolderProperty'(plugin: 'jte'){
      tier {
        baseDir configBaseDir
        scm(class: "hudson.plugins.git.GitSCM", plugin: "git@3.9.1"){
          configVersion 2
          userRemoteConfigs{
            'hudson.plugins.git.UserRemoteConfig'{
              url pipelineConfigRepo
            }
          }
          branches{
            'hudson.plugins.git.BranchSpec'{
              name '*/master'
            }
          }
          doGenerateSubmoduleConfigurations false
          submoduleCfg(class: list)
          extensions ''
        }
        librarySources{
          'org.boozallen.plugins.jte.config.TemplateLibrarySource'{
            scm(class: "hudson.plugins.git.GitSCM", plugin: "git@3.9.1"){
              configVersion 2
              userRemoteConfigs{
                'hudson.plugins.git.UserRemoteConfig'{
                  url libraryRepo
                }
              }
              branches{
                'hudson.plugins.git.BranchSpec'{
                  name '*/master'
                }
              }
              doGenerateSubmoduleConfigurations false
              submoduleCfg(class: list)
              extensions ''
            }
          }
        }
      }
    }

  }
}