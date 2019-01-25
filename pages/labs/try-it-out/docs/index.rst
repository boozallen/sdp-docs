.. _Try It Out: 

Try It Out
===========

Welcome to the Try It Out lab for the Solutions Delivery Platform!

========
Overview
========

The purpose of this guide is to help you set up the Solutions Delivery Platform on your own local computer so that you can try it out and see what magic it can do!

It will walk you though the steps of setting up core DevOps tools using Docker containers, creating a simple pipeline for some sample Spring Boot API code,
and utilizing some of the key features of the Jenkins Templating Engine, such as :ref:`Organizational Governance <conditional inheritance>`.

The pipeline itself will be able to build a Docker image from a sample Spring Boot API application and perform code analysis on it as well using SonarQube.

=============
Prerequisites
=============

    * A text editor
    * You have `Git`_ installed on your machine 
    * You have `Docker`_ installed on your machine

        - For your Docker resources, you will need at least 2CPUs, 3.0GIB Memory, and 1.0GIB Swap to ensure that everything within this guide can run properly
    
        - Follow the sections under the Advanced section to change the resources you allocate to Docker depending on if you have a `Windows`_ computer or a `Mac`_ computer. 

.. _Windows: https://docs.docker.com/docker-for-windows/#advanced
.. _Mac: https://docs.docker.com/docker-for-mac/#preferences-menu
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
