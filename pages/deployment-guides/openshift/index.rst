SDP on Openshift Deployment Guide
=================================

========
Overview
========

When you complete this guide, you should have a functioning deployment of the
SDP. This includes a Jenkins master, one or more Jenkins agents, and services
used by SDP libraries, such as Sonarqube.

This guide also covers setting up a space in Openshift
that can be automatically deployed to using the "Openshift" SDP Library. This
includes a Tiller server for deployments via Helm, as well as separate
application environments such as "Dev" and "Test"

.. toctree::
   :maxdepth: 2
   :glob:
   :caption: Contents:

   1_0_Deploy_Tools_Overview
   1_1_Prepare_To_Install
   1_2_Run_Installer
   2_0_Pipeline_Config_Overview
   2_1_Pipeline_Planning
   2_2_Pipeline_Config
   3_0_Application_Environment_Overview
   3_1_Application_Environments
   3_2_Helm_Chart_Repo

**Click on the Next button to continue on to the Section 1 of this guide*
