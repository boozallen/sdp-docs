.. _Getting Started:
---------------
Getting Started
---------------

Welcome to the Getting Started Guide for the Solutions Delivery Platform!

========
Overview
========

The purpose of this guide is to help you set up the SDP and become familiar with
it's various parts. It will walk you though the steps to set up core DevOps tools,
create a simple pipeline, and establish some governance rules.

.. note::

    Because one of the goals of this guide is to cover *how* the SDP is set up, we
    intentionally avoid some certain shortcuts. A quick-start guide will be made
    available in the future.

=============
Prerequisites
=============

While the SDP can support a variety of automated pipelines (data ingest,
infrastructure as code, etc.), we have focused primarily on creating libraries
for building end-to-end DevSecOps pipelines for containerized applications. The
getting started guide will cover this particular use-case.

Furthermore, this guide will be operating under some assumptions:

* You're using GitHub (public or enterprise) to host source code. If you don't
have source code to use for this getting started guide, free to fork this
`example project`_.
* You can access the relevant `GitHub repositories`_.
* Your workstation is running OSX or Linux, either natively or in a VM
* You have Docker installed on your workstation

.. _example project: https://github.com/kottoson-bah/sdp-example-proj
.. _GitHub repositories: https://github.com/boozallen/?utf8=✓&q=sdp


.. note:: Support of other git based scm's and non-git scm's are on the roadmap, but have not yet been implemented.

=====
Tools
=====

This getting started guide assumes some familiarity with:

* GitHub, or your source code manager (SCM) of choice
* Docker, a containerization tool

=================
Let's Get Started
=================

Use the ``previous`` and ``next`` buttons to navigate through this guide.


.. toctree::
   :hidden:
   :titlesonly:

   deploying_devops_tools
   configuration_of_sdp
   configure_conditional_inheritance_hierarchy
