Section 3.1 - Creating the Application Environments
===================================================

========
Overview
========

The first prerequisite for using the |openshift_library|'s |deploy_step| is a
set of pre-configured projects in Openshift:

* The application environments, one or more projects that will host the application (e.g. "my-app-dev" & "my-app-prod")
* A project to host container images that are shared between the application environments
* A project to host the |tiller_server| that manages the application environments.

You can create all of these using the |provision_app_envs_script|.

=============
Prerequisites
=============

In addition to the prerequisites covered in the |section_overview|, make sure

1) You are logged into the Openshift cluster you're deploying to as a user with the |cluster-admin role|
2) None of the projects that the provision app envs script will create already exist (not likely if this is your first run)

=============================
Getting provision_app_envs.sh
=============================

Clone the |sdp-helm-chart_repository| if you haven't already, and use your
terminal to navigate to the ``resources/helm`` folder. You should see a file called
``provision_app_envs.sh``. You can execute it with the ``-h`` flag to view the
options for running it.

.. code-block:: shell

  $ git clone https://github.com/boozallen/sdp-helm-chart.git
  Cloning into 'sdp-helm-chart'...
  remote: Enumerating objects: 182, done.
  remote: Counting objects: 100% (182/182), done.
  remote: Compressing objects: 100% (135/135), done.
  remote: Total 438 (delta 93), reused 108 (delta 45), pack-reused 256
  Receiving objects: 100% (438/438), 2.26 MiB | 5.40 MiB/s, done.
  Resolving deltas: 100% (211/211), done.
  $ cd sdp-helm-chart/resources/helm
  $ bash provision_app_envs.sh -h
  script usage:
  -p | set's the tenant prefix.
  -e | define an app env. can be used multiple times.
  -i | defines the project images will be pushed to.

  example:
    ./provision_app_envs.sh -p rhs -e dev -e test -e staging -e prod -i red-hat-summit

  this example would create the following projects:
   1) rhs-tiller     | tiller server for this tenant
   2) red-hat-summit | project for storing pushed images
   3) rhs-dev        | dev app environment
   4) rhs-test       | test app environment
   5) rhs-staging    | staging app environment
   6) rhs-prod       | prod app environment
  where:
   1) rhs-{dev,test,staging} can pull images from red-hat-summit
   2) rhs-tiller can deploy resources to rhs-{dev,test,staging}

.. ' adding this comment to clean up the linter

=================================
The Options You Need to Decide On
=================================

You need a prefix for the application environment names. It's an arbitrary
name that makes it possible to distinguish your application from others that may
share the same cluster. This prefix is ideally an abbreviation of your project
name. In the example above, the prefix for the "RedHat Summit" project is "rhs."

You need to know how many environments you want, and abbreviated names for each.
For each of these environments you will add ``-e <env>``. In the example above,
there are four environments being provisioned: dev, test, staging, and prod. The
script will create an Openshift project for each one: rhs-dev, rhs-test,
rhs-staging, and rhs-prod.

.. note::

  These abbreviated names map to the "short names" of the |application_environments|
  in your pipeline configuration file(s).

You need a name for the project hosting the container images. This is the
*full name of the project* and will not necessarily include the prefix (unlike
the other projects being created). In the example above, that project is called
"red-hat-summit".

==================
Running The Script
==================

Putting it all together, execute the provision_app_envs script, using the
appropriate flags to provide the three pieces of information covered above.

.. code-block:: shell

  $ bash provision_app_envs.sh -p $PREFIX -e $ENV_1 -e $ENV_2 ... -e $ENV_N -i $IMAGE_PROJ

The script should take care of the rest, creating and setting up projects for
the application environments, images, and tiller server.


.. |openshift_library| raw:: html

    <a href="/pages/libraries/openshift/README.html" target="_blank">OpenShift library</a>

.. |deploy_step| raw:: html

    <a href="https://github.com/boozallen/sdp-libraries/blob/master/openshift/deploy_to.groovy" target="_blank">the deploy step</a>

.. |tiller_server| raw:: html

   <a href="https://docs.helm.sh/glossary/#tiller" target="_blank">Tiller server</a>

.. |provision_app_envs_script| raw:: html

   <a href="https://github.com/boozallen/sdp-helm-chart/blob/master/resources/helm/provision_app_envs.sh" target="_blank">provision_app_envs script</a>

.. |sdp-helm-chart_repository| raw:: html

   <a href="https://github.com/boozallen/sdp-helm-chart" target="_blank">sdp-helm-chart repository</a>

.. |application_environments| raw:: html

    <a href="http://localhost:8000/pages/jte/docs/pages/Templating/primitives/application_environments.html" target="_blank">application environments</a>


.. https://docs.openshift.com/container-platform/3.11/architecture/additional_concepts/authorization.html#roles

.. https://docs.openshift.com/container-platform/3.11/admin_guide/manage_rbac.html#managing-role-bindings
