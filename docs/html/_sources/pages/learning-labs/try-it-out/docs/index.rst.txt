.. _Try It Out: 

==========
Try It Out
==========

Welcome to the Try It Out Lab for the Solutions Delivery Platform (SDP)!

--------
Overview
--------

The purpose of this lab is to help you set up the Solutions Delivery Platform
on your own local computer so that you can try it out!

This lab will help you deploy a preconfigured Jenkins instance with SDP configured as well
as a local SonarQube instance so that you will be able to run a sample pipeline that builds 
a Spring Boot application while performing static code analysis. 

The `sample application GitHub repository`_ represents a web application that users of SDP
might want to create a pipeline for.

.. _sample application GitHub repository: https://github.com/boozallen/sdp-labs-sample-app


-------------
Prerequisites
-------------

**Local Environment**: 

    * A text editor
    * You have `Git`_ installed on your machine 
    * You have `Docker for Mac`_ or `Docker for Windows`_ installed on your machine

        - For your Docker resources, you will need at least 2CPUs, 3.0GIB Memory, and 1.0GIB Swap to ensure that everything within this guide can run properly
    
        - Follow the sections under the Advanced section to change the resources you allocate to Docker depending on if you have a `Windows`_ computer or a `Mac`_ computer 

.. _Docker for Mac: https://docs.docker.com/docker-for-mac/install/

.. _Docker for Windows: https://docs.docker.com/docker-for-windows/install/

.. _Windows: https://docs.docker.com/docker-for-windows/#advanced
.. _Mac: https://docs.docker.com/docker-for-mac/#preferences-menu
.. _Git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
.. _Docker: https://docs.docker.com/install/

**Skills**: The following skills would prove helpful but not needed to get through this lab

    * Docker
    * Git / GitHub 
    * Jenkins 
    * Static Code Analysis (with SonarQube)

.. note:: 

    Use the ``previous`` and ``next`` buttons to navigate through this guide.


.. toctree::
   :hidden:
   :titlesonly:

   pages/environment-preparation
   pages/sdp-overview
   pages/pipeline-configuration-file
   pages/jenkinsfile
   pages/create-github-credentials
   pages/run-jenkins-build.rst
   pages/troubleshooting.rst
