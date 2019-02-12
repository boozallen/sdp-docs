Section 1.1 - Preparing to Run the Installer
==========================================

==================
Log into OpenShift
==================

Run the command here, replacing the URI shown with the one for your cluster's
master node(s). The URI is the one you use to reach your OpenShift web console.

.. code::

   $ oc login master.ocp.example.com:8443

When prompted, use the login for your cluster-admin User.

===================================
Clone the sdp-helm-chart Repository
===================================

To clone the |sdp-helm-chart_repository|, run one of the following commands:

.. code::

  ## cloning via ssh
  $ git clone git@github.com:boozallen/sdp-helm-chart.git
  ## cloning via https
  $ git clone https://github.com/boozallen/sdp-helm-chart.git

=======================
Create Your Values File
=======================

From the root of your new sdp-helm-chart directory, copy values.template.yaml
to values.yaml.

.. code::

  $ cp values.template.yaml values.yaml

The installer script will use the settings defined in this file when deploying
the SDP.

.. note::

   This extra step is intended to prevent users from inadvertently pushing their
   values.yaml file, which may contain sensitive information.

======================
Modify the Values File
======================

The only value that you *must* change in values.yaml is ``global.domain``. You
should change it to match the subdomain your cluster uses for exposed routes. To
easily see what that subdomain is for your cluster, you can run
``oc get routes -n default`` and look at the entries under the HOST/PORT column.
It will be everything past the first period (.), so if one of the entries is
``docker-registry-default.apps.ocp.example.com``
then values.yaml should contain:

.. code-block:: yaml

  global:
    domain: apps.ocp.example.com

You can also add to your values file any of the values described in the
|sdp-helm-chart_repository| README.

While the SDP installation will deploy SonarQube and other tools, you
can opt not to install them by changing their "enable" setting from ``true``
to ``false``.

.. |sdp-helm-chart_repository| raw:: html

   <a href="https://github.com/boozallen/sdp-helm-chart" target="_blank">sdp-helm-chart repository</a>
