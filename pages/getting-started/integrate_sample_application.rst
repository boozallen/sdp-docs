.. _integrate_sample_application:

##############################
Integrate a Sample Application
##############################

How to integrate a sample web application with the Jenkins Templating Engine(JTE)

Recap
=====

If you've been following each part of the guide, you should now have a Jenkins instance configured to use the JTE and a Jenkins Folder object with a GitHub Organization within it.


Overview
========

We will now be configuring a sample web application to use the Jenkins Templating Engine (JTE).

After we're done with this section, we will have done the following:

    * The sample application will inherit all of the pipeline configurations from the JTE Sample Folder's configurations as well as the GitHub organization created in the :ref:`Configuration of SDP<configuration_of_sdp>` section's pipeline configurations
    * Ensured certain things happen when developers make a commit, pull request, or merge to the **master** branch of the repository

Adding a Repository to an Organization
--------------------------------------

In order to do this, we will need the application to be in the GitHub Organization created in the :ref:`Configuration of SDP<configuration_of_sdp>` section of the Getting Started guide.

In the GitHub Organization, `create a new repository`_ for the sample application. Let's just call the repository **Sample-App**.

Let's create a pipeline_config.groovy that will apply to only this repository.

The pipeline_config.groovy will include the following content:

::

    application_environments{
    prod{
        short_name = "prod"
        long_name = "Production"
    }
    }

    stages{
    continuous_integration{
        static_code_analysis
        build
        scan_container_image
    }
    }

    libraries{
    github_enterprise
    sonarqube{
        enforce_quality_gate = true
    }
    docker
    twistlock{
        url = "<your twistlock url>" //for example: "https://twistlock.apps.ocp.microcaas.net"
        credential = "<your twistlock credential>"
    }
    openshift{
        url = "<your openshift url" //for example: "https://master.ocp.microcaas.net:8443"
        tiller_namespace = "<your tiller namespace>"
        tiller_credential = "<your tiller credential>"
    }
    }


The pipeline_config.groovy file above defines a new stage called **continuous_integration()**, which would run the perform static code analysis using the SonarQube library, build a Docker image from the code using the Docker library, and scanning the built docker image to ensure there aren't any security vulnerabilities using Twistlock. It also defines one new application environment called "production."

.. important:: For this repository to be recognized by JTE, you **must** include a Jenkinsfile somewhere within the repository. We recommend just putting it in the root directory of the repository, though you can put it anywhere your heart desires.

A sample Jenkinsfile that you can use can be found below. Here is the Jenkinsfile:

::

    on_commit{
        continuous_integration()
    }

    on_pull_request to: master, {
    continuous_integration()
    }
    }

    on_merge to: master, {
    deploy_to prod
    }


The Jenkinsfile utilizes three Jenkins steps that we have defined within the GitHub Enterprise library that we created: **on_commit**, **on_pull_request to**, and **on_merge to**. They do exactly what they sound like:

    * on_commit: When a user makes a commit to any branch, it does the steps defined in the **continuous_integration()** stage found in the stages section of the pipeline_config.groovy
    * on_pull_request to: When a user makes a pull request to the master branch, it does the steps defined in the **continuous_integration()** stage found in the stages section of the pipeline_config.groovy
    * on_merge to: When a merge request is accepted in the master branch, it utilizes the deploy_to() step that we created within the Openshift library to deploy to the environment called "prod" defined within the repository's pipeline_config.groovy file




.. _create a new repository: https://help.github.com/articles/create-a-repo/


Congratulations! You have now configured a GitHub repository with a sample application to use a specific pipeline configuration. To verify that everything is working, you can go to the master branch of the Sample-Application code repository within Jenkins and click **Build Now**. Watch the magic happen within the **Console Output** of the respective build you just started!
