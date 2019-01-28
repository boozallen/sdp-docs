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
to the ability to setup a configuration hierarchy, where multiple code
repositories can be forced to inherit a single set of pipeline configuration
settings. Groups of these parent pipeline configs can in turn be forced to
inherit certain configuration settings, and so on.

You can easily customize which parts of the pipeline configuration can
(or cannot) be overridden by a child pipeline config. From a security and testing
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
and call it "child-governance-tier" (the name is arbitrary). This folder will hold the pipeline configurations for the Organization Job that we made in the |Configuration of SDP section|. Inside that folder, create a new
file named *pipeline_config.groovy*, with the following contents:

.. |Configuration of SDP section| raw:: html

   <a href="/pages/getting-started/configuration_of_sdp.html" target="_blank">Configuration of SDP section</a>


.. code-block:: groovy

    keywords{
      message = "Starting My Pipeline"
    }

The ``keywords`` section of the pipeline_config allows us to create some global
variables for our pipeline. For example, the |default_pipeline_config| provides
a few keywords to make it easier to use the |github_enterprise| pipeline library.
We can say ``on_commit to: develop`` and the ``develop`` keyword points to
a regular expression that should match your *develop* branch (or *Develop*,
*development*, etc.)

.. |github_enterprise| raw:: html

   <a href="https://github.com/boozallen/sdp-libraries/tree/master/github_enterprise" target="_blank">github enterprise</a>


.. |default_pipeline_config| raw:: html

   <a href="https://github.com/boozallen/jenkins-templating-engine/blob/master/src/main/resources/org/boozallen/plugins/jte/config/pipeline_config.groovy" target="_blank">default pipeline config</a>

Once you add the child-governance-tier folder and pipeline_config.groovy file, your
repository should have a file structure like this:

::

  pipeline-config
  |-  Jenkinsfile
  |-  pipeline_config.groovy
  |-  child-governance-tier
         |- pipeline_config.groovy


Update the Top Tier Pipeline Configuration File
-----------------------------------------------

Now that we've added a section (``keywords``) to what will be a lower-level
governance tier, we need to update what will be our higher-level governance tier
(the one in the root of *pipeline-config*) to allow that section to be used. As
things stand, the *keywords* section in *pipeline-config/child-governance-tier/pipeline_config.groovy*
would  be completely ignored because *pipeline-config/pipeline_config.groovy*
doesn't explicitly allow for that section to be overwritten. Check out the page
on :ref:`conditional inheritance` for more information.

Go back to your top-level pipeline config file (i.e.
pipeline-config/pipeline_config.groovy) and add a keywords section that allows
for merges. The final file should look like this:

.. code-block:: groovy

    libraries{
      sdp{
        images{
          registry = "http://docker-registry.default.svc:5000" // registry url
          cred = "sdp-docker-registry"// jenkins cred id to authenticate
          repo = "sdp"       // repo to find sdp images -> currently hard coded as "sdp"
          docker_args = "--network=try-it-out_sdp"  // docker runtime args
        }
      }
      github_enterprise
      docker{
        registry = "docker-registry.default.svc:5000" // registry url
        cred = "sdp-docker-registry"// jenkins cred id to authenticate
      }
    }

    keywords{
      merge = true
    }


Note the added ``keywords`` section. It has only one field: ``merge``. This is a
**reserved** field name in pipeline configuration files. We can add ``merge = true``
to any section of this file, and the settings in "lower" pipeline config files
will be merged into this file to synthesize a pipeline's final, aggregated pipeline
file. In this case, we want to allow our child-governance-tier's keyword to be used, so we
allow its ``keywords`` section to be merged with this config file. This is
explained in more detail on the :ref:`conditional inheritance` page.


Add a New Pipeline Template
---------------------------

Now that we've added a keyword, and we've given our pipeline permission to use
it, we should create a new pipeline template that uses this keyword. In the
previous section of the Getting Started Guide, we created a default pipeline
template that builds a container image. With our current pipeline configuration
repository, it will still use that pipeline template.

Add a new pipeline template, also called Jenkinsfile, to the child-governance-tier folder
we created. It should look like this:

.. code-block:: groovy

    stage(message){
      echo message
    }
    build()

This will create a new pipeline stage in Jenkins, called "Starting My Pipeline"
(the "message" keyword), and in that stage Jenkins will print out the message
to the console log. To read more about what a stage is and how they can be used within SDP, visit the |Stages| page in the For SDP Users section.

.. |Stages| raw:: html

   <a href="/pages/for-sdp-users/stages.html" target="_blank">Stages</a>


Now your pipeline configuration repo should look like this:

::

  pipeline-config
  |-  Jenkinsfile
  |-  pipeline_config.groovy
  |-  child-governance-tier
         |- Jenkinsfile
         |- pipeline_config.groovy

When searching for a pipeline template, the JTE will start at the lowest-level
governance tier and, if it can't find it there, traverse up governance-tiers
until it finds one. Since we plan to use the child-governance-tier folder as the
lower governance tier, that means that the JTE will now choose the template we
just created for the pipeline.

Create a Jenkins Folder With Governance
=======================================

We now have two directories in our pipeline-config repository that can serve as
governance tiers, each with their own pipeline_config.groovy file. However, the
JTE doesn't know from the file structure how we want to use these governance
tiers. We need to configure that within Jenkins ourselves.

We'll be creating a folder object in Jenkins, using the root of our pipeline
config repository as its Configuration Base Directory, moving our Organization Job
into that folder, and then updating that Organization Job to use the child-governance-tier folder we created
as *its* Configuration Base Directory.

First, create a Folder in Jenkins. We'll be configuring it much like how we
configured the GitHub Organization job in the previous section.
On the Jenkins starting screen on the left hand side, click "New Item."

For the "item name," put *Super-Organization* (The name is arbitrary). Click "Folder" and
then click OK.

On the top navigation tabs, you should see a *Jenkins Templating Engine* tab.
Clicking it should take you to the configuration section to specify the location
of the pipeline configuration we'd like to use for this folder.

In the Source Location Input Field, click *Git*.

In the Repository URL Input Field, enter the GitHub Repository URL for the
pipeline-config repo.

In the Credentials dropdown, find the credentials you use to access your GitHub
account.

Leave the	Branch Specifier field untouched. This field specifies which GitHub branch within the pipeline-config repository should be used, which should be the **master** branch, assuming that is the name of the branch where you put all the desired pipeline config-related folders and files. 
This field should generally just be changed when you want to use an alternative branch for your pipeline (i.e. for testing purposes).

Leave the Configuration Base Directory field empty. This tells JTE to use the
root of the repository as the base directory.

You can now click *Apply* and then *Save*.

You now have a Folder item that you put things under so that they may
inherit the settings in its pipeline config file.

.. The configurations should look something like the following picture with the
.. credentials field being replaced by your own.


Putting an Organization Into a Folder
=====================================

In this section, we will be placing the organization we created in the previous
section into the Jenkins folder that we just created.

Go back to the Jenkins homepage (you can do this by clicking on the Jenkins logo
in the top left) and click the name of the organization job. On the left hand
menu you should see a *move* option. Click it, and you will be redirected to a
screen asking where you'd like to to move the organization to. In the dropdown,
select *Jenkins » Super-Organization*. The organization job should now be under the
folder we just created.


Update the Organization Job's Governance
====================================

The next step is to update our Organization Job in Jenkins to use our new
governance tier. From the Jenkins home page, click on the Project folder,
the Organization job, then *Configure*. Click on the *Jenkins Templating Engine*
tab on the top to go down to relevant settings. In the *Configuration Base
Directory* field enter the name of the "child-governance-tier" folder we created in the
pipeline config GitHub Repository. This'll tell the Organization job to use
the pipeline config file in *that* folder as its config file. Click *Save* to
save these changes.


Run the Pipeline
================

Go back to one of the repository jobs inside the organization project inside the
folder we created and run another build. You should see a step called
"Starting My Pipeline."

.. note::

   While we defined this "step" block manually in the Jenkinsfile, you don't need to
   specify these when using a pipeline step provided by a library (i.e. the
   *build()* step from the Docker library) since they do this within the step.


If you still have any questions about how to configure your DevOps pipelines to
utilize a conditional inheritance hierarchy or if you have any advanced use
cases, take a look at the :ref:`conditional inheritance` section.

Feel free to try changing the keyword value in the different pipeline config
files and making small changes to the pipeline templates to get a better feel
for how conditional inheritance works.
