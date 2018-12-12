.. _deploying_devops_tools:

######################
Deploying DevOps Tools
######################

Recap
=====

At this point you should have read the introduction page and made sure
that the prerequisites were met.

* You either have an application with source code in GitHub or you've forked https://github.com/kottoson-bah/sdp-example-proj.
* You have access to `boozallen SDP GitHub repositories`_
* You have Docker installed

.. _boozallen SDP GitHub repositories: https://github.com/boozallen/?utf8=✓&q=sdp

Overview
========

In this section of the getting started guide, we'll be deploying Jenkins and
installing the JTE Jenkins plugin.

Deploy Jenkins
==============

Jenkins is responsible managing our automated workflows.
|There are a number of ways to deploy Jenkins|. One requirement for this guide,
however, is that you're able to run Docker commands from a Jenkins
pipeline/script. If you're running Jenkins on your laptop, where Docker is
installed, that shouldn't be a problem.

.. note::

   If installing Jenkins on a Mac/OSX machine, it's recommended to install
   Jenkins using the "Generic Java package (.war)" and then
   |following the instructions here|, as there have been issues with using
   private GitHub repositories when installing Jenkins from the pkg file.

.. |There are a number of ways to deploy Jenkins| raw:: html

    <a href="https://jenkins.io/download/" target="_blank">There are a number of ways to deploy Jenkins</a>

.. |following the instructions here| raw:: html

    <a href="https://jenkins.io/doc/book/installing/#war-file" target="_blank">Following the instructions here</a>


Follow the instructions on the screen to perform the initial Jenkins setup.
Create an admin user and install the recommended plugins.

Once that wraps up, we need to install the JTE plugin. Clone and build the
|JTE_plugin| following the instructions in the README. Then, from your Jenkins'
homepage, click on Manage Jenkins, Manage Plugins, Advanced, and under Upload
Plugin click Choose File. Select the **jte.jpi** file (it should be under
build/libs in your JTE folder), then click Upload. After loading and
restarting, Jenkins will have installed the JTE plugin.

.. |JTE_plugin| raw:: html

   <a href="https://github.com/boozallen/jenkins-templating-engine" target="_blank">JTE Repository</a>
