.. _deploying_devops_tools:

######################
Deploying DevOps Tools
######################

Recap
=====

At this point, you should have read the introduction page and made sure
that the prerequisites were met.
    * You either have an application with source code in GitHub or you've forked https://github.com/kottoson-bah/sdp-example-proj
    * You have access to `boozallen SDP GitHub repositories`_
    * You have `Docker`_ installed

.. _Docker: https://docs.docker.com/install/
.. _boozallen SDP GitHub repositories: https://github.com/boozallen/?utf8=✓&q=sdp

Overview
========

In this section of the Getting Started Guide, we'll be deploying Jenkins and
installing the JTE Jenkins plugin.

Deploy Jenkins
==============

Jenkins is responsible for managing our automated workflows.
|There are a number of ways to deploy Jenkins|. One requirement for this guide,
however, is that you're able to run Docker commands from a Jenkins
pipeline/script. If you're running Jenkins on your laptop where Docker is
installed, that shouldn't be a problem.

.. note::

   If installing Jenkins on a Mac/OSX machine, it's recommended that you install
   Jenkins using the "Generic Java package (.war)" and
   |follow the instructions here|, as there have been issues with using
   private GitHub repositories when installing Jenkins from the pkg file.

.. |There are a number of ways to deploy Jenkins| raw:: html

    <a href="https://jenkins.io/download/" target="_blank">There are a number of ways to deploy Jenkins</a>

.. |follow the instructions here| raw:: html

    <a href="https://jenkins.io/doc/book/installing/#war-file" target="_blank">follow the instructions here</a>


Follow the instructions on the screen to perform the initial Jenkins setup.
Create an admin user and install the recommended plugins.

Once that wraps up, build and install the JTE plugin Following the instructions on the
|Installing_JTE| page. Alternatively, follow the instructions in the README file of the JTE Repository. Then, from your Jenkins'
homepage, click on Manage Jenkins, Manage Plugins, Advanced, and under Upload
Plugin, click Choose File. Select the **jte.jpi** file (it should be under
build/libs in your JTE folder), then click Upload. After loading and
restarting, Jenkins will have installed the JTE plugin.

.. |Installing_JTE| raw:: html

   <a href="/pages/jte/docs/pages/installation.html" target="_blank">Installing JTE</a>
