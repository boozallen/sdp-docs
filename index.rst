.. overview: 

===========================
Solutions Delivery Platform
===========================

The Solutions Delivery Platform (SDP) is an accumulation of Booz Allen's lessons learned 
implementing DevSecOps practices across multiple client projects and RFP Tech Challenges 
such as NSF, GSA IAE, CMS PECOS, and Grants.Gov. 

At Booz Allen, DevSecOps is a foundational element of our Modern Software development
Approach

.. image:: images/sdp/modern-sd-approach.png
   :align: center
   :scale: 75%

Over the past two years, we've developed an open source and reusable pipeline framework 
that jump starts projects. SDP has allowed the typical time to develop a pipeline from 
3 to 4 months down to just a week. 

Instead of creating per-application pipelines, SDP allows you to create tool-agnostic,
templated workflows that can be used by multiple teams to achieve organizational governance. 

----------
Components
----------

********************************
Container Orchestration Platform
********************************

The container orchestration platform, typically a kubernetes based solution, is 
responsible for hosting the DevOps tools; such as Jenkins or SonarQube. 

.. note:: 

    There is no strict dependency on OpenShift or Kubernetes, though this will 
    enable a more robust platform. 

*************************
Jenkins Templating Engine 
*************************

The Jenkins Templating Engine is a custom plugin written by Booz Allen that enables the 
capabilities of the Solutions Delivery Platform; such as organizational governance through 
templating and hierarchical configuration files. 

.. important:: 

    This plugin will soon be hosted in the official Jenkins Update Center 

**********************
SDP Pipeline Libraries
**********************

The SDP Pipeline Libraries are our reusable tool integrations that contain the 
actual technical implementations of pipeline actions; such as static code analysis,
penetration testing, and deployments.

*******************
DevSecOps Dashboard
*******************

Your DevSeCops pipeline is able to observe everything about software delivery for your 
project or organization. Through SDP, you would be able to aggregate these metrics into 
a DevSecOps dashboard to enable continuous improvement of your processes. 



.. toctree::
   :hidden:
   :maxdepth: 1
   :titlesonly:

   pages/libraries/index
   pages/jte/docs/index
   pages/labs/index
   pages/deployment-guides/index
   pages/how-to/index
