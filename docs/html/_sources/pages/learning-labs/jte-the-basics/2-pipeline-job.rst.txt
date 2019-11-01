.. JTE The Basics Pipeline Job: 

------------------
Write the Template
------------------

In JTE, instead of creating application-specific ``Jenkinsfiles`` we create pipeline templates 
that represent the business logic of a pipeline in a tool-agnostic way. 

=====================
Create a Pipeline Job
===================== 

To demonstrate this, first create a ``Pipeline`` job.

1. From the Jenkins home page, navigate to ``New Item`` in the lefthand navigation menu. 
2. Enter a name for the job to be created
3. Select ``Pipeline`` from the list of available job types
4. Click ``OK`` 

.. image:: ../../../images/learning-labs/jte-the-basics/create_pipeline_job.gif
   :align: center 

==================
Write the Template
==================

********
Overview
********

For this lab, let's create a pipeline that can build an artifact with maven
and then perform static code analysis with SonarQube. 

Scroll down on the job's configuration page to the ``Pipeline`` configuration section. 

Make sure that ``Jenkins Templating Engine`` is selected in the ``Definition`` drop down
configuration option. 

In the ``Pipeline Template`` text box, enter: 

.. code:: groovy

    build()
    static_code_analysis() 

.. note:: 

    A word on vocabulary: The entire script above is called a **Pipeline Template**.  
    Pipeline Templates invoke **steps**, in this case build & static_code_analysis, that
    are implemented by **libraries**.

You can click ``Apply`` to save your progress.  In the next section we'll be creating the 
pipeline libraries that implement the ``build()`` and ``static_code_analysis()`` steps. 
