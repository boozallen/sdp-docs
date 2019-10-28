.. Local Development Validate Jenkins: 

----------------
Validate Jenkins
----------------

That's it!  You've now deployed and configured a local Jenkins instance. 

We're going to run through a couple quick steps to ensure that the deployed 
Jenkins can launch containers as part of the pipeline. 

=====================
Create a Pipeline Job
=====================

1.  From the Jenkins home page, select *New Item* in the lefthand navigation menu.
2.  Enter a name for the job.  `validate` will do. 
3.  Select the *Pipeline* job type.
4.  Click *ok* at the bottom of the screen. 

====================
Configure a Pipeline
====================

1.  Scroll down to the *Pipeline* configuration section 
2.  The *Definition* drop down should already be set to *Jenkins Templating Engine* 

.. important:: 

    This confirms that JTE has been installed successfully

3.  In the *Pipeline Template* text box, enter: 

.. code:: groovy

    docker.image("maven").inside{
        sh "mvn -v" 
    }

.. note:: 

    The pipeline configured pulls the latest ``maven`` image from Docker Hub 
    and executes the command `mvn -v` within that container image. 

    This will validate that the local Jenkins can pull container images, run them,
    and then execute pipeline commands inside the launched container. 


.. image:: ../../../images/learning-labs/local-development/job-configuration.png 
   :align: center 


4.  Click *Save* at the bottom of the screen. 
5.  This will redirect you back to the job's main page.  Click *Build Now* in the lefthand navigation menu. 
6.  Under *Build History* select *#1* to navigate to the build page
7.  In the lefthand navigation menu, select *Console Output* to read the build logs
8.  Confirm that the pipeline successfully pulled the ``maven`` container image
9.  Confirm that the command ``mvn -v`` executed successfully and shows the maven version
10.  Validate that the build finished successfully. 


If all went well, the console output should show something like: 


.. image:: ../../../images/learning-labs/local-development/console-output.png 
   :align: center 