.. _Deploy Devops Tools:
-----------------------
Deploy The Devops Tools
-----------------------

In this section, you will be deploying all of the DevOps tools that we will be using within this tutorial. This consists of deploying a Jenkins instance, a SonarQube server, and a local (insecure) Docker registry. 

.. note:: The tools that we will be utilizing throughout this tutorial are not fully secure and thus not production-ready. They are meant to just be a showcase of what SDP itself can do. 

To begin, clone our SDP-Labs_ GitHub repository, which includes all of the files you'll need to use throughout our guide. 

.. _SDP-Labs: https://github.com/boozallen/sdp-labs

.. code-block:: bash

   ## cloning via ssh
   git clone git@github.com:boozallen/sdp-labs.git
   ## cloning via https
   git clone https://github.com/boozallen/sdp-labs.git

**If you haven't already**, use one of the above commands to clone the repository to your computer. 

In your terminal, navigate to the inside of the ``sdp-labs`` directory that you just cloned from GitHub.

Run the following command in your terminal from the top-level directory of the ``sdp-labs`` directory to deploy the Docker containers using the `provided docker-compose.yaml file`_ within the ``try-it-out`` directory. For some more information about docker-compose files, visit `this page`_.

.. _provided docker-compose.yaml file: https://github.com/boozallen/sdp-labs/blob/master/try-it-out/docker-compose.yaml

.. code-block:: bash

   docker-compose -f ./try-it-out/docker-compose.yaml up -d --scale sonar-scanner=0

.. note:: The ``docker-compose`` command run above may not work on a company's WIFI depending on its firewall settings, so you may need to run it on a private network or where firewall rules are more lax. 

.. _this page: https://docs.docker.com/compose/compose-file/

The above command will create and run the following Docker containers: Jenkins, a Docker registry, and SonarQube. To verify this, you can run ``docker ps`` in your terminal. 

The response should show something similar to the following screenshot.

.. image:: ../images/deploy-devops-tools/docker_ps_command.png

For your conenvience, we have already automated the following thing to allow you to focus on the usage of SDP:
    
    * Creation of Jenkins Credentials to be able to access SonarQube as well as your local Docker registry
    * Downloading all the needed plugins required for the SDP including the Jenkins Templating Engine plugin
    * Creation of a webhook within SonarQube to notify your Jenkins instance that code analysis was successfully completed

=================================
Register Insecure Docker Registry
=================================

To be able to use and access the Docker registry that you just deployed, you will need to add the Docker registry's IP Address and Port (which you can find using ``docker ps``) to the list of insecure registries found in your Docker Preferences.

Follow the instructions under the section labeled "Deploy a plain HTTP registry" on the following website to do so within the format of ``IP_Address:Port``: https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry

.. note:: The URL of the Docker registry should not be preceded by **http://** when being added to the list of insecure registries.


========
Validate
========

