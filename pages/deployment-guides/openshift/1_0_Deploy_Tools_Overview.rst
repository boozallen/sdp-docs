Section 1 - Deploying the DevOps Tools
======================================

==================
Section 1 Overview
==================

Once you have completed this section, you should have a functioning deployment
of the SDP. This includes a Jenkins master, one or more Jenkins agents, and
services used by SDP libraries, such as SonarQube.

================
Before You Begin
================

------------------
You Should Have...
------------------

* A working OpenShift cluster
* Credentials for a User on that cluster that has the *cluster-admin* role
* Access to the relevant GitHub Repositories
* The Helm client installed (https://docs.helm.sh/using_helm/#installing-helm)
* The OpenShift CLI installed

    * OCP: https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html
    * OKD: https://docs.okd.io/3.11/cli_reference/get_started_cli.html#cli-reference-get-started-cli

------------------------
You Should Be Able To...
------------------------

* Modify simple configuration files
* Run bash commands/scripts

===================
System Requirements
===================

* Your OpenShift cluster meets the minimum hardware requirements as laid out in
  the documentation
    * OCP 3.11 (formerly OpenShift Enterprise): https://docs.openshift.com/container-platform/3.11/install/prerequisites.html
    * OKD 3.11 (formerly OpenShift Origin): https://docs.okd.io/3.11/install/prerequisites.html
* Your cluster has enough available CPU and Memory for the SDP containers (see below)
* Your cluster has enough remaining CPU and Memory for your application and
  any additional services (such as Prometheus, for monitoring)

==========================
Additional Recommendations
==========================

* Your OpenShift cluster is able to create Persistent Volumes
    * OCP 3.11: https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/index.html
    * OKD 3.11: https://docs.okd.io/3.11/install_config/persistent_storage/index.html
* Your OpenShift cluster is able to dynamically create said Persistent Volumes
    * OCP 3.11: https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/dynamically_provisioning_pvs.html
    * OKD 3.11: https://docs.okd.io/3.11/install_config/persistent_storage/dynamically_provisioning_pvs.html

.. note::

   While not required to deploy the SDP, persistent volumes allow for safely
   restarting containers without loosing any storage or history. It can also make
   certain pipeline actions faster, such as building Docker images.


==================================
Container Resource Recommendations
==================================

+----------------+---------------+------------------+--------------+
|  **Container** | **CPU (ea.)** | **Memory (ea.)** | **Quantity** |
+----------------+---------------+------------------+--------------+
| Jenkins Master | 1000m         | 3000Mi           | 1            |
+----------------+---------------+------------------+--------------+
| Jenkins Agent  | 1000m         | 1500Mi           | 1*           |
+----------------+---------------+------------------+--------------+
| SonarQube      | 250m          | 2000Mi           | 1            |
+----------------+---------------+------------------+--------------+

+-----------+----------------+--------------------+
| **Total** | **CPU**: 2250m | **Memory**: 5500Mi |
+-----------+----------------+--------------------+

*\* While only one Jenkins Agent is required, it's highly recommended to have more.
The quantity depends on how frequently Jenkins builds are run.*
