.. _JTE The Basics Prerequisites: 

-------------
Prerequisites
-------------

================
Jenkins Instance
================

A Jenkins instance will be required for this lab.  If you don't have one available to you,
we would recommend going through the :ref:`Local Development<Local Development>` learning lab 
to deploy a local Jenkins instance through Docker. 

=====================================
Ability to Create GitHub Repositories
===================================== 

When creating your first set of pipeline libraries and externalizing the pipeline configuration 
from Jenkins you will need to be able to create GitHub repositories on `github.com <https://github.com>`_.  

.. note:: 

    Theoretically, any git-based SCM provider (BitBucket, GitHub, GitLab, etc) should integrate and 
    work as expected with JTE.  For the purposes of simplifying this lab, we will be using GitHub. 

==========================================
GitHub PAT in the Jenkins Credential Store
==========================================

Create a `GitHub Personal Access Token <https://help.github.com/en/github/authenticating-to-github/creating-a-personal-access-token-for-the-command-line>`_. 

Copy this token and store it in the Jenkins credential store. 

1.  From the Jenkins home page, click ``Credentials`` in the lefthand navigation menu
2.  Select the ``global`` credential scope 
3.  Select ``Add Credential`` in the lefthand navigation menu
4.  Enter your github username in the ``Username`` field 
5.  Paste the Personal Access Token into the ``Password`` field 
6.  Enter ``github`` into the ``ID`` field 
7.  Enter ``github`` into the ``Description`` field 
8.  Click ``OK``

.. image:: ../../../images/learning-labs/jte-the-basics/pat.gif 
   :align: center 