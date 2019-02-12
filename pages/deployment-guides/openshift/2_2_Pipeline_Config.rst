Section 2.2 - Creating the Pipeline Configuration Repository
============================================================

There are as many ways to create a set up a Pipeline Configuration Repository
as there are ways to create software. This guide should provide a good foundation to
build off of.

This page covers the creation of a simple pipeline configuration repository, a
repository that contains files that define one or more pipelines, containing a
single governance tier. |More_on_pipeline_governance|.

===================
Create a Repository
===================

Use an SCM like GitHub to create a repository to store your pipeline
configuration. This way you can access, share, and maintain pipeline configuration
like any other piece of code.

==========================
Create a Pipeline Template
==========================

At the root of this repository create a file called ``Jenkinsfile``. This is
the default pipeline template. A simple pipeline template might look like this:

.. code-block:: groovy

  static_code_analysis()
  build()

  on_merge to: develop, {
    deploy_to dev
  }

  on_merge to: master, {
    deploy_to prod
  }

Head to the bottom of the page for details on this pipeline template. It makes
more sense after creating the pipeline config file.

.. note::

   |More_on_writing_pipeline_templates|



=============================
Create pipeline_config.groovy
=============================

Also at the root of your pipeline configuration repository, create a file
called ``pipeline_config.groovy``. Since this file will (likely) be in your global
governance tier, you modify it to make changes that apply to every pipeline. A
simple pipeline config file might look like this:

.. code-block:: groovy

  application_environments{
    dev{
      short_name = "dev"
      long_name = "Develop"
    }
    prod{
      short_name = "prod"
      long_name = "prod"
    }
  }

  keywords{
    master = /^[Mm]aster$/
    develop = /^[Dd]evelop$/
  }

  libraries{
    github_enterprise
    sonarqube
    docker{
      registry = "docker-registry.default.svc:5000"
      cred = "openshift-docker-registry"
      repo_path_prefix = "my-app-images"
    }
    sdp{
      images{
        registry = "https://docker-registry.default.svc:5000"
        repo = "sdp"
        cred = "openshift-docker-registry"
      }
    }
    openshift{
      // More on these settings in the next section
      url = "https://my-openshift-cluster.ocp.example.com:8443"
      helm_configuration_repository = "https://github.com/kottoson-bah/sdp-example-helm-config.git"
      helm_configuration_repository_credential = github
      tiller_namespace = my-app-tiller
      tiller_credential = my-app-tiller-credential
    }
  }

.. note::

   |More_on_writing_pipeline_config_files|

.. important::

    The pipeline defined by this example won't work until you've finished
    setting up your application environment in Openshift and written your helm
    configuration repository, which is covered in the next section.

========================================
About The Example Pipeline Configuration
========================================

If you're using the example pipeline template and pipeline config file above,
this section explains how they work together to create a pipeline. Feel free to
move onto the next section if you're already comfortable with the material.

---------------------
The Pipeline Template
---------------------

Starting with the pipeline template, every pipeline created from this template
will have these steps:

.. code-block:: groovy

  static_code_analysis() // 1) Check the source code for bugs & code smells
  build()                // 2) Build an artifact from the source code

  on_merge to: develop, {// 3a) if a merge to the develop branch triggered the build...
    deploy_to dev        // 3b) deploy the application to the "dev" environment
  }

  on_merge to: master, {// 4a) if a merge to the master branch triggered the build...
    deploy_to prod      // 4b) deploy the application to the "prod" environment
  }

Now that the pipeline template has defined *what* a pipeline does, there needs
to be a pipeline config file to define *how*. It needs |libraries| to provide the
implementation for the pipeline steps, |application_environments| to define
the dev and prod environments being deployed to, and |keywords| for the
variables ``develop`` and ``master`` being used.

-------------
The Libraries
-------------

.. code-block:: groovy

    libraries{
      github_enterprise
      sonarqube
      docker{
        registry = "docker-registry.default.svc:5000"
        cred = "openshift-docker-registry"
        repo_path_prefix = "my-app-images"
      }
      sdp{
        images{
          registry = "https://docker-registry.default.svc:5000"
          repo = "sdp"
          cred = "openshift-docker-registry"
        }
      }
      openshift{
        // More on these settings in the next section
        url = "https://my-openshift-cluster.ocp.example.com:8443"
        helm_configuration_repository = "https://github.com/kottoson-bah/sdp-example-helm-config.git"
        helm_configuration_repository_credential = github
        tiller_namespace = my-app-tiller
        tiller_credential = my-app-tiller-credential
      }
    }

For every step used in a pipeline template, something needs to define that
step's implementation. For the JTE, these step implementations come from
"libraries", which are imported from a "library source". For this example
pipeline, it's assumed that the |sdp-libraries| library source is available, and
any of the libraries it contains can be used.

Five libraries are being imported here: github_enterprise, sonarqube, docker,
sdp, and openshift. Below is a mapping of steps to the libraries that are
being used.

.. code-block:: groovy

  static_code_analysis() // sonarqube
  build()                // docker

  on_merge to: develop, {// github_enterprise
    deploy_to dev        // openshift
  }

  on_merge to: master, {// github_enterprise
    deploy_to prod      // openshift
  }

Although the sdp library doesn't provide the implementation for one of the steps
here, it's being imported because both the sonarqube and openshift libraries
depend on a step it defines.

.. note::

   |More_on_sdp_libraries|

----------------------------
The Application Environments
----------------------------

.. code-block:: groovy

    application_environments{
      dev{
        short_name = "dev"
        long_name = "Develop"
      }
      prod{
        short_name = "prod"
        long_name = "prod"
      }
    }

The |openshift_library| uses |Application_Environment_primitives| to select which
project in OpenShift to deploy to. For example, when the pipeline template calls
``deploy to: dev``(which can also be read as ``deploy(to: dev)``), it takes the
*dev* application environment primitive object that we define here and uses its
values in |the_deploy_step|. The ``short_name``, in particular, is used to select
the target Openshift project and which values.yaml file to use as part of the
deployment. View the next section or the |openshift_library| page for more
details.

------------
The Keywords
------------

.. code-block:: groovy

    keywords{
      master = /^[Mm]aster$/
      develop = /^[Dd]evelop$/
    }

The |github_enterprise_library| uses |Keyword_primitives| to determine what kind
of GitHub branch is being built. The steps ``on_merge()``, ``on_commit``, and
``on_pull_request`` take a regex expression as a parameter. These regex
expressions have been stored as keywords to make the pipeline template more
human-readable.

===============
Closing Summary
===============

This pipeline configuration repository, with a single governance tier located in
the base of the repository, contains two files: *Jenkinsfile* and
*pipeline_config.groovy*. The default pipeline template, *Jenkinsfile*, defines
the steps that each pipeline executes. The pipeline configuration file,
*pipeline_config.groovy*, controls how those steps are run in the pipeline by
defining the libraries to implement those steps, the settings for those libraries,
and any other pipeline primitives being used.

Using the files in this example, pipelines will:

1) test the source code using Sonarqube
2) build & push a Docker container image
3) depending on the pipeline trigger, deploy that container on OpenShift

==========
Next Steps
==========

You should be able to move onto the next section, which covers creating a Helm
chart repository. For more on the information covered in this section:

* |More_on_writing_pipeline_templates|
* |More_on_writing_pipeline_config_files|
* |More_on_sdp_libraries|
* |More_on_writing_libraries|


.. |More_on_pipeline_governance| raw:: html

    <a href="/pages/jte/docs/pages/Governance/index.html" target="_blank">You can learn more about pipeline governance here</a>

.. |More_on_writing_pipeline_templates| raw:: html

    <a href="/pages/pages/jte/docs/pages/Templating/index.html" target="_blank">You can learn more about writing pipeline templates here</a>

.. |More_on_writing_pipeline_config_files| raw:: html

    <a href="/pages/jte/docs/pages/Templating/configuration_files/index.html" target="_blank">You can learn more about writing pipeline config files here</a>

.. |libraries| raw:: html

    <a href="/pages/jte/docs/pages/Governance/index.html#library-selection" target="_blank">libraries</a>

.. |application_environments| raw:: html

    <a href="/pages/jte/docs/pages/Templating/primitives/application_environments.html" target="_blank">application environments</a>

.. |keywords| raw:: html

    <a href="/pages/jte/docs/pages/Templating/primitives/keywords.html" target="_blank">keywords</a>

.. |sdp-libraries| raw:: html

    <a href="https://github.com/boozallen/sdp-libraries" target="_blank">sdp-libraries</a>

.. |openshift_library| raw:: html

   <a href="/pages/libraries/openshift/README.html" target="_blank">OpenShift library</a>

.. |Application_Environment_primitives| raw:: html

   <a href="/pages/jte/docs/pages/Templating/primitives/application_environments.html" target="_blank">Application Environment primitives</a>

.. |the_deploy_step| raw:: html

  <a href="https://github.com/boozallen/sdp-libraries/blob/master/openshift/deploy_to.groovy" target="_blank">the deploy step</a>

.. |github_enterprise_library| raw:: html

   <a href="/pages/libraries/github_enterprise/README.html" target="_blank">github_enterprise library</a>

.. |Keyword_primitives| raw:: html

    <a href="/pages/jte/docs/pages/Templating/primitives/keywords.html" target="_blank">Keyword primitives</a>

.. |More_on_sdp_libraries| raw:: html

    <a href="/pages/libraries/index.html" target="_blank">You can learn more about the SDP pipeline libraries here</a>

.. |More_on_writing_libraries| raw:: html

    <a href-"/pages/jte/docs/pages/Library_Development/index.html" target="_blank">You can learn more about writing your own pipeline libraries here</a>
