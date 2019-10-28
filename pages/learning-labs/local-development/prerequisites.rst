.. Local Development Prerequisites: 

-------------
Prerequisites
-------------

======
Docker
======

Ensure Docker is installed and running on your local machine.

You can validate docker is running by running ``docker ps`` in your terminal.  

You should see output similar to: 

.. image:: ../../../images/learning-labs/local-development/empty_docker_ps.png 
   :align: center

=====================
Internet Connectivity
===================== 

The Jenkins LTS container image from Docker Hub will be used in this course.  You can validate your ability to download 
this container image by running ``docker pull jenkins/jenkins:lts``.   

You should see output similar to: 

.. image:: ../../../images/learning-labs/local-development/docker_pull_jenkins.png
   :align: center