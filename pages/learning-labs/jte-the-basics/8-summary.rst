.. _JTE The Basics Summary: 

-------
Summary
-------

We learned a lot in this lab!  Let's recap some of what we learned: 

=============================
GitHub Credentials in Jenkins
=============================

We learned how to create a Personal Access Token and store it in the 
Jenkins credential store. 

While credentials are not strictly needed for public repositories, 
GitHub will API Rate Limit your Jenkins instance which can dramatically 
slow down the pipeline and cause it to fail. 

===============================
Different Types of Jenkins Jobs
===============================

We learned about the three kinds of Jobs most commonly used when working with 
the Jenkins Templating Engine. 

.. csv-table:: Jenkins Pipeline Job Types 
   :header: "Job Type", "Description"
   :widths: 20, 75

    "Pipeline Job", "Best suited for one-off tasks or debugging pipelines developed with JTE." 
    "Multibranch Projects", "Represent an entire GitHub repository and create a job for every branch and Pull Request" 
    "GitHub Organization Projects", "Represent an entire GitHub Organization.  Can be filtered to restrict which repositories are automatically represented in Jenkins."

================================
What makes up a pipeline in JTE? 
================================

We learned that: 

1.  **Pipeline Templates** can call **steps** contributed by **libraries**.
2.  Pipeline Templates are responsible for the **business logic** of your pipeline
3.  Libraries are responsible for the **technical implementation** of your pipeline 
4.  Pipeline Configuration Files **implement** a template by specifying (among other things) what libraries to load
4.  When stored in a repo, Pipeline Configuration Files are called ``pipeline_config.groovy`` and are located at the root of the repository

==========================
What is a Governance Tier?
==========================

We learned that: 

1.  Governance Tiers are a way to **externalize configuration** into source code repositories 
2.  A Governance Tier is made up of a Pipeline Configuration Repository and a set of Library Sources 
3.  Pipeline Configuration Repositories optionally contain a pipeline template and a pipeline configuration file 
4.  The Jenkinsfile is the **default pipeline template** in a Governance Tier 

=======================
How to Reuse Templates?
=======================

We learned that: 

1.  Pipeline Templates can be applied to multiple repositories simultaneously through the GitHub Organization Job Type 
2.  Pipeline Configuration Files can be aggregated between Governance Tiers and an application repository itself
3.  There are rules around **conditional inheritance** when it comes to Pipeline Configuration Aggregation 