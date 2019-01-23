.. _Create Git Repository for a Pipeline Configuration:

-------------------------------------------------------
Create a GitHub Repository for a Pipeline Configuration
-------------------------------------------------------

In this step, you will be creating a GitHub repository that has a pipeline configuration within it. 

The **Pipeline Configuration Repository** is a Git repository where organization-wide settings are configured for your DevSecOps pipelines.
This repository will contain your business organization or project’s configuration file, which specifies the organization-wide libraries you’d like to utilize within the platform, the application environments, your pipeline templates, and more. 

For this example, you will be configuring a pipeline configuration repository that will be able to perform static quality analysis on a tool called SonarQube and to build a Docker image if the given code reaches a certain code quality based on the analysis.

While this example of a pipeline configuration only uses two software tools (Docker and SonarQube), there are many other tools that have been already integrated with SDP. For more information about the libraries that have already been integrated with SDP, go here:

.. code-block:: bash

    https://boozallen.github.io/sdp-pipeline-framework/pages/libraries/index.html

==========================
Create a GitHub Repository
==========================

To start, open up a new tab on your browser and then navigate to https://github.com/.

After signing in using your GitHub credentials, you will first create a new repository by going to the upper-hand corner of the screen and clicking the **plus symbol**.
Click the **New repository** option to start creating a repository.

.. image:: ../images/create-repository-for-pipeline-config/create-github-repo.png

You should now be taken to a screen to **Create a new repository**.
For the repository name, let’s just call it **pipeline-configuration**.
The name of the repository itself is arbitrary, though this name will be referenced in the next section when you specify the settings for your Jenkins pipeline.

You can make it either public or private depending on if you want this repository to be available to the general public.
Do not check the checkbox to initialize the GitHub repository with a README, as you be creating a directory with the right files to push to Git in your computer’s terminal.
You can add a **.gitignore** file if you want and give it the license type you’d like your project to have.

After doing so, you can now click **Create repository**.

You should be taken to a screen describing how you can upload files from your local computer to the GitHub repository.
As you haven’t created any files for the pipeline-configuration repository yet, let’s start there.


==================================
Create Pipeline Configuration File
==================================


Choose a location for your project files, and create a new directory called **pipeline-configuration**.

In a text editor, create a file within the pipeline-configuration directory called **pipeline_config.groovy** with the following content:

.. code-block:: bash

    sdp_image_repository = "http://0.0.0.0:5000"
    sdp_image_repository_credential = "sdp-docker-registry"
    application_image_repository = "0.0.0.0:5000"
    application_image_repository_credential = "sdp-docker-registry"

    libraries{
        sdp
        github_enterprise	
        sonarqube{
            enforce_quality_gate = true
        }
        docker
    }

.. note:: You may need to change the IP Address of the ``sdp_image_repository`` and ``application_image_repository`` depending on what it is for your docker registry.

This file has several parts to it.
In general, it consists of configuring some parameters for the local Docker registry URLs and their respective credentials that you will be using later in this guide as well as specifying all the libraries that you will be using.

In the section enclosed by **libraries**, we declare each of the libraries that we’d like to use within our pipeline and set any parameters that we need to set for the respective library.
As there are no mandatory library configuration options you need to set for the Docker library, you can leave it blank.
However, in the sonarqube stage, we set the enforce_quality_gate boolean variable to be true so that the Jenkins build will fail if the code does not pass the quality gate, or some general code quality percentage, which is configurable in SonarQube itself.

For more information about the Docker and Sonarqube libraries, you can go here:
    * Docker: https://boozallen.github.io/sdp-pipeline-framework/pages/libraries/docker.html
    * SonarQube: https://boozallen.github.io/sdp-pipeline-framework/pages/libraries/sonarqube.html

For a list of all the libraries that have already been integrated with SDP in general, you can visit our libraries page `here`_.

.. _here: https://pages.github.boozallencsn.com/solutions-delivery-platform/pipeline-framework/pages/libraries/

When you’re done creating the pipeline_config.groovy file and saving it to the pipeline-configuration directory, you will now push the files to the GitHub repository you made in the previous step.

===================================
Pushing Code to a GitHub Repository
===================================

In your terminal, navigate to the inside of your pipeline-configuration directory, which should now only contain a **pipeine_config.groovy** file.
Afterwards, enter the following commands into your terminal to push the contents of that directory (which should only consist of the pipeline_config.groovy file) to the GitHub repository.

.. code-block:: bash

    echo "# pipeline-configuration" >> README.md
    git init
    git add .
    git commit -m "first commit"
    git remote add origin https://github.com/organization-name/pipeline-configuration.git
    git push -u origin master

.. note:: Make sure that you replace **organization-name** within the github URL with the name of your `GitHub organization`_ or, more likely, the username of your GitHub account if that's where you created the GitHub Organization earlier in this page.

.. _GitHub Organization: https://help.github.com/articles/about-organizations/


