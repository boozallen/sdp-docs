.. _JTE The Basics Apply to Multiple Repositories: 

-------------------------------------
Apply to Multiple GitHub Repositories
-------------------------------------

Next up, we'll see how to apply the same template to two different 
applications that are using different tools. 

Let's walk through how you would setup JTE to this situation where 
one application is using maven, the other application is using gradle,
and both applications are using SonarQube. 

==============================
Create a New GitHub Repository 
==============================

We already have a pipeline configuration repository that has our pipeline template, 
pipeline configuration file, and pipeline libraries as well as a repository 
that represents an application using gradle. 

Follow the same procedure as before when creating the gradle application's repository 
to create a maven application repository named ``jte-the-basics-app-maven``. 

==================================
Modify the Pipeline Configurations
==================================

Now that there are multiple applications with some configurations that are common
and some configurations that are unique, we need to introduce the concept of 
pipeline configuration aggregation. 

*********************************************
Modify the Governance Tier Configuration File
*********************************************

We need to edit the pipeline configuration file (``pipeline_config.groovy``) we created 
earlier to represent the **common** configurations that will be applied to both apps 
and explicitly *allow* these applications to add their own configurations. 

**pipeline-configuration/pipeline_config.groovy**: 

.. code:: groovy 

    libraries{
        merge = true 
        sonarqube 
    }

.. note:: 

    In this configuration, both applications are using SonarQube.  Since this is 
    a common configuration, we'll leave it in the Governance Tier's configuration file. 

    The application repositories will each get their own ``pipeline_config.groovy`` to 
    indicate if they are using the ``maven`` or the ``gradle`` library. 

    Since we want to allow these apps to add *additional* configurations, we need to be 
    explicit about that by setting ``merge = true`` in the ``libraries`` block of the 
    pipeline configuration. 

.. important:: 

    When aggregating pipeline configurations, JTE applies *conditional inheritance* during 
    the aggregation process.  To learn more on conditional inheritance,
    `read the docs <https://jenkinsci.github.io/templating-engine-plugin/pages/Governance/config_file_aggregation.html>`_. 


**************************************************************
Create a Pipeline Configuration File for the Maven Application
**************************************************************

In the ``jte-the-basics-app-maven`` repository we just created, add a 
``pipeline_config.groovy`` file at the root that specifies you want to 
load the ``maven`` library. 

**pipeline_config.groovy**: 

.. code:: groovy

    libraries{
        maven
    }

.. note:: 

    Since this application will inherit the global configurations defined in the 
    Governance Tier, we don't have to duplicate the configuration of loading the 
    sonarqube library in the repo level pipeline configuration. 


***************************************************************
Create a Pipeline Configuration File for the Gradle Application
***************************************************************

In the ``jte-the-basics-app-gradle`` repository we created earlier for the 
Multibranch Project, add a ``pipeline_config.groovy`` file at the root that
specifies you want to load the ``gradle`` library. 

**pipeline_config.groovy**: 

.. code:: groovy

    libraries{
        gradle
    }

====================================
Create a GitHub Organization Project
====================================

We created a ``Multibranch Project`` that automatically created jobs for every branch and 
Pull Request in a repository. 

Now, we'll create a ``GitHub Organization Project`` that can automatically create ``Multibranch Projects`` 
for every repository within a GitHub Organization. 

1.  From the Jenkins home page, select ``New Item`` in the lefthand navigation menu
2.  Select a name for the job.  
3.  Select the GitHub credential under the ``Credentials`` drop down menu 
4.  Enter your GitHub username under the ``Owner`` field 
5.  Under ``Behaviors`` click ``Add`` and select ``Filter by name (with wildcards)``
6.  Enter ``jte-the-basics-app-*`` in the ``Include`` text box (assuming you've following the naming recommendations of the application repositories)
7.  Under ``Project Recognizers`` hit the red X to delete the ``Pipeline Jenkinsfile`` Recognizers
8.  Under ``Project Recognizers`` select ``Add`` and click ``Jenkins Templating Engine``
9.  Click ``Save`` 

After creating the GitHub Organization job in Jenkins, you will be redirected to the logs of the GitHub Organization being 
scanned to find repositories that match the wildcard format entered during job creation.  This will scope the repositories for 
which jobs are created to just this lab's application repositories. 

Once scanning has finished, go view the GitHub Orgnization's job page in Jenkins and you will see two Multibranch Projects 
have been created for ``example-jte-app-gradle`` and ``example-jte-app-maven``. 

Explore each of these jobs to see that the ``gradle`` repository's pipeline loaded the ``gradle`` library and the ``maven`` 
repository loaded the ``maven`` library and both pipelines loaded the ``sonarqube`` library. 

.. image:: ../../../images/learning-labs/jte-the-basics/github_org.gif
   :align: center 

.. important:: 

    We just created a configuration where **multiple** applications used the **same** pipeline template, 
    shared a common configuration, but still have the flexibility to choose the correct build tool for 
    their application. 