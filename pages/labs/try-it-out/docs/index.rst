.. _Try it Out: 

Try It Out
===========

Welcome to the Try It Out page for the Solutions Delivery Platform!

========
Overview
========

The purpose of this guide is to help you set up the Solutions Delivery Platform on your own local computer so that you can try it out and see what magic it can do!

It will walk you though the steps of setting up core DevOps tools using Docker containers, creating a simple pipeline for some sample Spring Boot API code,
and utilizing some of the key features of the Jenkins Templating Engine, such as :ref:`Organizational Governance <conditional inheritance>`.

The pipeline itself will be able to build a Docker image from some Spring Boot API code and perform some code analysis on it as well using SonarQube.

=============
Prerequisites
=============

    * A text editor
    * You have `Gradle version 4.2.10`_ or above installed on your machine 
    * You have `Git`_ installed on your machine 
    * You have `Docker`_ installed on your machine

        - For your Docker resources, you will need at least 2CPUs, 3.0GIB Memory, and 1.0GIB Swap to ensure that everything within this guide can run properly
    
        - Follow the sections under the Advanced section on these sites depending on your operating machine to change the resources you allocate to Docker: https://docs.docker.com/docker-for-windows/#advanced or https://docs.docker.com/docker-for-mac/#preferences-menu   

.. _Gradle version 4.2.10: https://gradle.org/install/#manually
.. _Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
.. _Docker: https://docs.docker.com/install/

=================
Let's Get Started
=================

Without further ado, let's get started!

Use the ``previous`` and ``next`` buttons to navigate through this guide.


.. toctree::
   :hidden:
   :titlesonly:

   pages/deploy-devops-tools
   pages/choose-jenkins-pipeline-type
   pages/create-repository-for-pipeline-config
   configure_jenkins_in_chart
   deploy_sdp
   configure_sdp
   configure_openshift_library
   create_org_pipeline
   configure_tenant_repo
   verify
