
============
SDP Overview
============

At this point, you have a local SDP environment with a
`Jenkins server`_, a `SonarQube server`_, and a `Container Registry`_. 

.. _Jenkins server: http://localhost:8080
.. _Sonarqube server: http://localhost:9000
.. _Container Registry: http://localhost:5000/v2/_catalog

------------
What is SDP?
------------

At the heart of it, the Solutions Delivery Platform is a Jenkins pipeline framework that allows you 
to create templated, tool-agnostic workflows to be used by multiple applications simultaneously.  

------------------
Pipeline Templates
------------------

Templates are defined either alongside an application in the source code repository or within a 
:ref:`Governance Tier <Governance Model>`. 

.. note:: 

    In this lab, we've defined the pipeline template via a Jenkinsfile within the sample app 
    repository.

The pipeline template is responsible for defining the business logic of the pipeline.  When a
developer does something in GitHub, what should the pipeline do? These templates define this 
logic by calling generic **step** names like ``unit_test()``, ``build()``, ``deploy_to``, etc. 

The implementation for these steps is done by modularizing particular tool integrations into 
pipeline libraries. 

------------------
Pipeline Libraries
------------------

A pipeline library is a building block for your pipeline template. When loaded, it supplies 
an implementation of steps contained within the library. 

To learn more, please check out the :ref:`SDP Libraries <>` we have already completed.  If you need 
to add your own steps or develop new tool integrations for SDP, refer to :ref:`Library Development <>`
for how to create your own library. 

-------------------
Configuration Files
-------------------

If the pipeline template is just responsible for outlining a generic workflow to be followed - there
must be something that determines how to implement this template. That's where pipeline configuration 
files come in. 

The pipeline configuration file is responsible for determining what your pipeline template will actually 
do.  The bulk of this configuration file is often the ``libraries`` portion, where you specify 
which libraries should be loaded along with their configuration. 

Each our libraries can be seen via our Documentation and each library page will outline any 
configuration options available alongside any other relevant information for the library. 

The next section will go over the sample application's pipeline template and pipeline 
configuration file in detail. 