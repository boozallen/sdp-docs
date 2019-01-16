=================================
SDP on Openshift Deployment Guide
=================================

--------
Overview
--------
When you complete this guide, you should have a functioning deployment of the
SDP on Openshift that you could reasonably use on a project. This includes a
Jenkins master, one or more Jenkins agents, and services used by SDP libraries,
such as Sonarqube.

This guide also covers setting up a space in Openshift
that can be automatically deployed to using the "Openshift" SDP Library. This
includes a Tiller server for deployments via Helm, different "environments" such
as "Dev" and "Test"

----------------
Before You Begin
----------------

You Should Have...
==================

* A working Openshift cluster
* Credentials for a User on that cluster that has the *cluster-admin* role
* Access to the relevant GitHub Repositories
* The Openshift CLI installed
    * OKD: https://docs.okd.io/3.11/cli_reference/get_started_cli.html#cli-reference-get-started-cli


You Should Be Able To...
========================

* Be able to modify simple configuration files
* Be able to run bash commands/scripts

-------------------
System Requirements
-------------------

* Your Openshift cluster meets the minimum hardware requirements as
  laid out in the documentation
    * OCP 3.11 (formerly Openshift Enterprise): https://docs.openshift.com/container-platform/3.11/install/prerequisites.html
    * OKD 3.11 (formerly Openshift Origin): https://docs.okd.io/3.11/install/prerequisites.html
* Your cluster has enough available CPU and Memory for the SDP containers (see below)
* Your cluster has enough remaining CPU and Memory for your application and
  any additional services (such as Prometheus, for monitoring)

--------------------------
Additional Recommendations
--------------------------

* Your Openshift cluster is able to create Persistent Volumes
    * OCP 3.11: https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/index.html
    * OKD 3.11: https://docs.okd.io/3.11/install_config/persistent_storage/index.html
* Your Openshift cluster is able to dynamically create Persistent Volumes
    * OCP 3.11: https://docs.openshift.com/container-platform/3.11/install_config/persistent_storage/dynamically_provisioning_pvs.html
    * OKD 3.11: https://docs.okd.io/3.11/install_config/persistent_storage/dynamically_provisioning_pvs.html


---------------------------------------
Container Minimum Resource Requirements
---------------------------------------

+----------------+---------------+------------------+--------------+
|  **Container** | **CPU (ea.)** | **Memory (ea.)** | **Quantity** |
+----------------+---------------+------------------+--------------+
| Jenkins Master | 1000m         | 2000Mi           | 1            |
+----------------+---------------+------------------+--------------+
| Jenkins Agent  | 1000m         | 1500Mi           | 1*           |
+----------------+---------------+------------------+--------------+
| Sonarqube      | 250m          | 2000Mi           | 1            |
+----------------+---------------+------------------+--------------+

+-----------+----------------+--------------------+
| **Total** | **CPU**: 2250m | **Memory**: 5500Mi |
+-----------+----------------+--------------------+

*\* While only one Jenkins Agent is required, it's highly recommended to have more.
The quantity depends on how frequently Jenkins builds are run.*

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Contents:

   *
