.. JTE The Basics First Configuration File: 

----------------------
Configure the Pipeline 
----------------------

With the libraries created now discoverable by JTE, we can configure the pipeline 
and run it! 

From the main Jenkins page, click the job created earlier in this lab.  
In the lefthand navigation menu, click ``Configure``. 

Scrolling down to the ``Pipeline`` portion of the job configuration, you should 
still see the pipeline template created earlier in the ``Pipeline Template`` 
text box: 

.. code:: groovy

    build()
    static_code_analysis() 

It's now time to configure and run the pipeline. 

In the ``Pipeline Configuration`` text box enter: 

.. code:: groovy 

    libraries{
        maven
        sonarqube 
    }

Click ``Save``. 

.. important:: 

    The ``libraries`` portion of the pipeline configuration file will 
    read much like an application's technical stack.  In this case, 
    we're telling JTE that during intialization of the pipeline that 
    it should load the ``maven`` and ``sonarqube`` libraries. 

    The ``maven`` library will provide the ``build()`` step and the 
    ``sonarqube`` library will provide the ``static_code_analysis()`` step. 

    With these steps now implemented, we can run the pipeline. 

================
Run the Pipeline
================ 

After clicking ``Save`` you'll be directed back to the main page for the job. 

To run the pipeline, click ``Build Now`` in the lefthand navigation menu. 

Refresh the page and you should see build number 1 in the ``Build History`` 
on the bottom lefthand side of the screen.  Click the link to go to the Build's 
page. 

In the lefthand navigation menu, click ``Console Output`` to view the build logs
for this run of the pipeline. 

.. code-block:: text

    Started by user admin
    Running in Durability level: MAX_SURVIVABILITY
    [Pipeline] Start of Pipeline
    [JTE] Pipeline Configuration Modifications (show)
    [JTE] Loading Library maven (show)
    [JTE] Library maven does not have a configuration file.
    [JTE] Loading Library sonarqube (show)
    [JTE] Library sonarqube does not have a configuration file.
    [JTE] Obtained Pipeline Template from job configuration
    [Pipeline] node
    Running on Jenkins in /var/jenkins_home/workspace/single-job
    [Pipeline] {
    [Pipeline] writeFile
    [Pipeline] archiveArtifacts
    Archiving artifacts
    [Pipeline] }
    [Pipeline] // node
    [JTE] [Step - maven/build.call()]
    [Pipeline] stage
    [Pipeline] { (Maven: Build)
    [Pipeline] echo
    build from the maven library
    [Pipeline] }
    [Pipeline] // stage
    [JTE] [Step - sonarqube/static_code_analysis.call()]
    [Pipeline] stage
    [Pipeline] { (SonarQube: Static Code Analysis)
    [Pipeline] echo
    static code analysis from the sonarqube library
    [Pipeline] }
    [Pipeline] // stage
    [Pipeline] End of Pipeline
    Finished: SUCCESS


As expected, JTE loaded the ``maven`` and ``sonarqube`` libraries and then 
executed the template. 

.. note:: 

    A couple points to note about the build log: 

    1. Any line that starts with ``[JTE]`` is a log coming from the Jenkins Templating Engine
    2. Pieces of JTE log output are hidden by default.  Clicking ``show`` will expand these sections. 
    3. The first part of the pipeline output shows the initialization process
        
        * pipeline configuration files being aggregated 
        * libraries being loaded 
    
    4. Before steps are executed, JTE will tell you which step is being run and what library contributed the step