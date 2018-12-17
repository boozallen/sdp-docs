.. _configure_conditional_inheritance_hierarchy:

######################################################
Configuration of the Conditional Inheritance Hierarchy
######################################################

Recap
=====

At this point, you should have deployed Jenkins and created pipelines for a
GitHub organization using the Jenkins Templating Engine (JTE).

Overview
========

This section describes how you can take advantage of one of JTE's best
features: **organizational governance**. Organizational governance refers
to the idea that you can setup a hierarchy where code repositories can be forced
to inherit certain configurations from a higher-level pipeline's configurations.

You can easily customize which parts of the pipeline configuration can
(or cannot) be overridden by a child repository. From a security and testing
perspective, this is a great way to ensure that the repositories in your
organization meet certain requirements. To make this work, we take advantage of
Jenkins' built-in tier system.

For this guide, we will be configuring a Jenkins Folder that has its own set of
pipeline settings, and then move our GitHub Organization Job we made previously
into it and observe how it inherits those settings.

Update the Pipeline Configuration
==================================

Create another Pipeline Configuration File
------------------------------------------

We'll start by creating a new set of governance rules in the "pipeline-config"
repository we created in the previous section. Create a new folder in that repo
and call it "gov-tier" (the name is arbitrary). Inside that folder create a new
file, *pipeline_config.groovy*, with the following contents:

.. code-block:: groovy

    keywords{
      message = "hello world"
    }

The keywords section of the pipeline_config allows us to create some global
variables for our pipeline. For example, the |github_enterprise| library's
``on_commit`` step can take a regex argument to check if a particular GitHub
branch has been committed to. By the |default_pipeline_config| has a couple of
regex expressions in the keywords section to match branch names for master,
develop, hotfix, and others.

.. |github_enterprise| raw:: html

   <a href="https://github.com/boozallen/sdp-libraries/tree/master/github_enterprise" target="_blank">github enterprise</a>


.. |default_pipeline_config| raw:: html

   <a href="https://github.com/boozallen/jenkins-templating-engine/blob/master/src/main/resources/org/boozallen/plugins/jte/config/pipeline_config.groovy" target="_blank">default pipeline config</a>

Once you add the folder and file, your pipeline-config repository should have a
file structure like this:

::

  pipieline-config
  |-  Jenkinsfile
  |-  pipeline_config.groovy
  |-  gov-tier
         |- pipeline_config.groovy


Update the Top Tier Pipeline Configuration File
-----------------------------------------------

Now that we've added a section (*keywords*) to what will be a lower-level
governance tier, we need to update what will be our higher-level governance tier
(the one in the root of *pipeline-config*) to allow that section to be used. As
things stand, the *keywords* section in *pipeline-config/gov-tier/pipeline_config.groovy*
would  be completely ignored because *pipeline-config/pipeline_config.groovy*
doesn't allow it.

Go


Add a New Pipeline Template
---------------------------


Create a Jenkins Folder With Governance
=======================================

We now have two directories in our pipeline-config repository that can serve as governance
tiers, each with their own pipeline_config.groovy file. Now to apply them in Jenkins.
We'll be using the config file in the root of our pipeline config repository for
a Jenkins folder, move our Organization Job into that folder, then update that
job to use the pipeline_config.groovy file that we just created.

First, create a Folder in Jenkins. We'll be configuring it much like how we
configured the GitHub Organization job in the previous section.
On the Jenkins starting screen on the left hand side, click "New Item."

For the "item name," put *Project*. Click "Folder" and then click
OK.

On the top navigation tabs, you should see a *Solutions Delivery Platform* tab.
Clicking it should take you to the configuration section to specify the location
of the pipeline configuration we'd like to use for this folder.

In the Source Location Input Field, click *Git*.

In the Repository URL Input Field, enter the GitHub Repository URL for the
pipeline-config repo.

In the Credentials dropdown, find the credentials you use to access your GitHub
account.

Leave the Configuration Base Directory field empty. This tells JTE to use the
root of the repository as the base directory.

You can now click *Apply* and then *Save*.

You now have a Folder item that you put things under so that they may
inherit the settings in its pipeline config file.

The configurations should look something like the following picture with the
credentials field being replaced by your own.


Putting an Organization Into a Folder
=====================================

In this section, we will be placing the organization we created in the previous
section into the Jenkins folder that we just created.

Go back to the Jenkins homepage (you can do this by clicking on the Jenkins logo
in the top left) and click the name of the organization job. On the left hand
menu you should see a *move* option. Click it, and you will be redirected to a
screen asking where you'd like to to move the organization to. In the dropdown,
select the option with *Jenkins » My Project*.

With that last action, you should now have a organization that inherits all the
pipeline configurations of the folder and the GitHub Organization Job, your
Organization, then Configure. Click on the Solutions Delivery Platform tab to
scroll down to the SDP settings, and in the Configuration Base Directory field


Update the Organization's Governance
====================================

The next step is to update our Organization Job in Jenkins to use our new
governance tier. From the Jenkins home page, click on the My Project folder,
the Organization job, then *configure*. Click on the *Solutions Delivery Platform*
tab on the top to go down to relevant settings. In the *Configuration Base
Directory* field enter the name of the "gov-tier" folder we created in the
pipeline config GitHub Repository. This'll tell the Organization job to use
the pipeline config file in *that* folder as its config file.


If you still have any questions about how to configure your DevOps pipelines to
utilize a conditional inheritance hierarchy or if you have any advanced use
cases, take a look at the :ref:`conditional inheritance` section.
