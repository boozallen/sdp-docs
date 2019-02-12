Section 3.2 - Setting up the Helm Chart Repository
==================================================

========
Overview
========

|Helm| is a tool for templating and managing Kubernetes and, by extension,
Openshift configuration as code. Any element in Openshift can be expressed as
as yaml or JSON. Helm lets you take that yaml and organize it, turn them into
a template, and, through tiller, use them to deploy to your cluster.

This helm chart repository is what the |openshift_sdp_library| will use to
deploy your application to Openshift. In it, you should create a helm chart that
defines the various |DeploymentConfigs|, |Services|, |Routes|, and other objects
your application needs to function.

===================
Create a Repository
===================

Use an SCM like GitHub to create a repository to store your helm chart. This way
you can access, share and maintain the helm chart like any other piece of code.

==================
Add Your Templates
==================



====================
Add The Values Files
====================

===============
Closing Summary
===============

==========
Next Steps
==========

.. |helm|
.. https://helm.sh/

.. |openshift_sdp_library|

.. |DeploymentConfigs|

.. |Services|

.. |Routes|
