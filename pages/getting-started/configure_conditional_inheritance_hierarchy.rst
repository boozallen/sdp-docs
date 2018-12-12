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
(or cannot) be overriden by a child repository. From a security and testing
perspective, this is a great way to ensure that the repositories in your
organization meet certain requirements. To make this work, we take advantage of
Jenkins' built-in tier system.

For this guide, we will be configuring a Jenkins Folder with two things in it: a
GitHub Organization and a repository from a different GitHub Organization. The
GitHub Organization and the unaffiliated GitHub repository will inherit the
pipeline configuration applied to the folder while being able to supply some of
their own configuration settings as well.

Create another Pipeline Configuration File
===========================================

We will start by creating a new GitHub organization and a GitHub repository
within it. The repository will have a pipeline configuration within it, so we
can use it for the folder Jenkins item that we will be creating further down
below.

We'll start by creating a new set of governance rules in the "pipeline-config"
repository we created in the previous section. Create a new folder in that repo
and call it "gov-tier" (the name is arbitrary). Inside that folder create a new
file, *pipeline_config.groovy*, with the following contents:

.. code-block:: groovy

    keywords{
      message = "hello world"
    }

The file sets up a single application environment called "dev" for pipelines
under this governance tier. With this new file, our pipeline-config repo should
have this file structure:

::

  pipieline-config
  |-  Jenkinsfile
  |-  pipeline_config.groovy
  |-  gov-tier
         |- pipeline_config.groovy

Create a Jenkins Folder With Governance
=======================================

We now have two directories in our pipeline-config repository that can serve as governance
tiers, each with their own pipeline_config.groovy file. Now to apply them in Jenkins.
First, create a Folder in Jenkins.
On the Jenkins starting screen on the left hand side, click "New Item."

.. image:: ../../images/getting-started/click-new-item.png
   :scale: 50%

For the "item name," put *Project*. Click "Folder" and then click
OK.

.. image:: ../../images/getting-started/select-folder-item.png
   :scale: 50%

To do this, first click the **Build Configuration** tab on the top navigation
tabs. In the dropdown labeled **mode**, select the Jenkins Templating Engine.

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

You now have a Folder Jenkins item that you put things under so that they may
inherit the pipeline configurations set in the Folder's settings.

The configurations should look something like the following picture with the
credentials field being replaced by your own.

.. image:: ../../images/getting-started/configure-jte-folder.png
   :scale: 50%


Putting an Organization Into a Folder
=====================================

In this section, we will be placing the organization we created before within
the Jenkins folder that we just created.

To do this, click the Jenkins logo on the top left corner of your. This should
take to you to the page with top-level Jenkins items.

Click the name of the organization that you created earlier from the list of
Jenkins jobs.

On the left hand menu, you should see a *move* option. Click it, and you will
be redirected to a screen asking where you'd like to to move the organization
to.

In the dropdown, select the option with *Jenkins » My Project*.

With that last action, you should now have a organization that inherits all the
pipeline configurations of the folder and the GitHub Organization Job, your
Organization, then Configure. Click on the Solutions Delivery Platform tab to
scroll down to the SDP settings, and in the Configuration Base Directory field


Update the Organization's Governance
====================================

The next step is to update our Organization Job in Jenkins to use our new
governance tier. From the Jenkins home page, click on the My Project,


If you still have any questions about how to configure your DevOps pipelines to
utilize a conditional inheritance hierarchy or if you have any advanced use
cases, take a look at the :ref:`conditional inheritance` section.
