Section 3 - Setting up the Application Environments
===================================================

==================
Section 3 Overview
==================

The |openshift_sdp_library| has a |deploy_step| that can be used to
deploy the most recent build of a particular service to a given
|OpenShift_project|. The first part of this section covers how to create and
configure the target OpenShift projects. The second part goes over how to create
a Helm repository, defines how your application is deployed.

================
Before You Begin
================

------------------
You Should Have...
------------------

* A working Openshift cluster
* Credentials for a User on that cluster that has the *cluster-admin* role
* Access to the relevant GitHub Repositories
* The Helm client installed (https://docs.helm.sh/using_helm/#installing-helm)
* The Openshift CLI installed

    * OCP: https://docs.openshift.com/container-platform/3.11/cli_reference/get_started_cli.html
    * OKD: https://docs.okd.io/3.11/cli_reference/get_started_cli.html#cli-reference-get-started-cli


------------------------
You Should Be Able To...
------------------------

* Modify simple configuration files
* Run bash commands/scripts



.. |openshift_sdp_library| raw:: html

   <a href="/pages/libraries/openshift/README.html" target="_blank">OpenShift library</a>

.. |the_deploy_step| raw:: html

   <a href="https://github.com/boozallen/sdp-libraries/blob/master/openshift/deploy_to.groovy" target="_blank">the deploy step</a>

.. |OpenShift_project| raw:: html

    <a href="https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/projects_and_users.html#projects" target-"_blank">OpenShift project</a>
