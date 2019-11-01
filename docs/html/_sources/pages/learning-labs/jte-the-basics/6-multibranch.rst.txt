.. _JTE The Basics Apply to Entire Repository: 

----------------------------
Apply to a GitHub Repository
----------------------------

So far we've learned: 

* what a pipeline template is (the business logic of your pipeline)
* how to create some mock pipeline libraries (just groovy files implementing a call method inside a directory in a repository)
* what the pipeline configuration does (implements the template so it actually does things)
* how to use the same pipeline template with two different tech stacks by modifying the pipeline configuration 

Next, we're going to learn how to apply a pipeline template to an entire GitHub repository. 

This is a more realistic scenario and it has the added benefit of taking the pipeline template 
and pipeline configuration file out of the Jenkins UI and storing them in a pipeline configuration 
repository. 

==========================================
Move the Pipeline Template to a Repository
==========================================

When creating libraries, we created a GitHub repository and stored the libraries in a
subdirectory called ``libraries``.  In this example, we can create a new subdirectory 
at the root of the repositories called ``pipeline-configuration``. 

.. note:: 

    The actual names of the ``libraries`` and ``pipeline-configuration`` subdirectories 
    do not matter and are configurable. 

Within this ``pipeline-configuration`` directory create a file called ``Jenkinsfile`` 
and populate it with the same contents as the ``Pipeline Template`` text box in the Jenkins 
UI. 

*pipeline-configuration/Jenkinsfile*: 

.. code:: groovy

    build()
    static_code_analysis() 

.. important:: 

    The ``Jenkinsfile`` is the **default pipeline template** that will be used.  It is 
    possible to define more than one pipeline template and let application teams select
    which template applies to them.  More on that later, or 
    `read the docs <https://jenkinsci.github.io/templating-engine-plugin/pages/Governance/pipeline_template_selection.html>`_. 

===============================================
Move the Pipeline Configuration to a Repository
===============================================

In the same ``pipeline-configuration`` directory, create a file called ``pipeline_config.groovy``. 

.. important:: 

    When the pipeline configuration is stored in a file in a source code repository, it 
    will always be called ``pipeline_config.groovy``. 

Populate this file with the same contents as the ``Pipeline Configuration`` text box in the 
Jenkins UI. 

*pipeline-configuration/pipeline_config.groovy*: 

.. code:: groovy

    libraries{
        gradle
        sonarqube
    }

The file structure in your GitHub repository should now look like this: 

.. code:: 

    .
    ├── libraries
    │  ├── gradle
    │  │   └── build.groovy
    │  ├── maven
    │  │   └── build.groovy
    │  └── sonarqube
    │      └── static_code_analysis.groovy
    └── pipeline-configuration
        ├── Jenkinsfile
        └── pipeline_config.groovy

=================================
Create the Global Governance Tier
=================================

Now that we have our template and pipeline configuration externalized into a 
source code repository, we have to tell Jenkins where to find it. 

From the Jenkins home page: 

1.  In the lefthand navigation menu click ``Manage Jenkins``
2.  Click ``Configure System``
3.  Scroll down to the ``Jenkins Templating Engine`` configuration section
4.  Select ``Git`` for the ``Source Location`` drop down menu
5.  Under ``Repository URL`` type the **https** URL for the GitHub Repository containing the libraries, template, and configuration file
6.  In the ``Credentials`` drop down menu, select the github credential created during the prerequisites
7.  Type ``pipeline-configuration`` in the ``Configuration Base Directory`` text box
8.  Click ``Save`` 

.. image:: ../../../images/learning-labs/jte-the-basics/global_governance_tier.gif 
   :align: center 


.. note:: 

    You just configured your first **Governance Tier**!  
    
    Governance Tiers are the combination of: 

    1. A pipeline configuration repository specifying where the pipeline configuration 
       file and pipeline templates can be found
    2. A set of library sources 

    When done in ``Manage Jenkins > Configure System`` it's called the Global Governance
    Tier and applies to every job on the Jenkins instance. 

    Governance Tiers can also be configured on every Folder in Jenkins.  When configured, they 
    apply to every Job within that Folder. 

    Through Governance Tiers, you can create a governance hierarchy that matches your organizational 
    hierarchy just by how you organize jobs within Jenkins. 


================================
Create an Application Repository
================================

We're going to apply the pipeline template and configuration file to every 
branch in a GitHub repository. 

1. Create a GitHub Repository that will serve as our mock application repository named ``jte-the-basics-app-gradle``
2. Initialize the Repository with a README
3. Modify the README in order to create a branch called `test` 


.. image:: ../../../images/learning-labs/jte-the-basics/create_gradle_repo.gif 
   :align:  center 

============================
Create a Multibranch Project
============================

Now that we have a GitHub repository representing our application, we can create a 
**Multibranch Project** in Jenkins. 

.. important:: 

    Multibranch Projects are Folders in Jenkins that automatically create pipeline jobs
    for every branch and Pull Request in the source code repository they represent. 

    Through JTE, we can configure each branch and Pull Request to use the **same** 
    pipeline template.  This *removes* the Jenkinsfile from the repository. 

1.  From the Jenkins home page, select ``New Item`` in the lefthand navigation menu
2.  In the ``Enter an item name`` text box, type ``gradle-app`` 
3.  Select ``Multibranch Pipeline`` as the job type 
4.  Click ``OK`` 
5.  Under ``Branch Sources > Add Source`` select ``GitHub`` 
6.  Select the github credential under the ``Credentials`` drop down menu
7.  Enter the **https** repository URL under ``Repository HTTPS URL``
8.  Under the ``Build Configuration`` select ``Jenkins Templating Engine`` from the ``mode`` drop down menu 
9.  Click ``Save``

When the job is created, you will be redirected to a page showing the logs for scanning 
the repository.  In the breadcrumbs at the top of the page, you can select ``gradle-app`` 
to see the folder overview. 

In this overview, you'll see two jobs in progress once the repository scan has repeated: a 
job for the ``master`` branch and a job for the ``test`` branch. 

When these jobs complete, clicking them will show that each branch executed the pipeline 
template with the same configuration. 

.. image:: ../../../images/learning-labs/jte-the-basics/multibranch.gif 
   :align: center 



