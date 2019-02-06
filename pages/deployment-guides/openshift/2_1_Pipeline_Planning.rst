Section 2.1 - Pipeline Planning
===============================

=========================
Identify Your Source Code
=========================

Where are you, or your team's developers, storing their code? Ideally, there's
some source code management tool (SCM) that's used to centralize, share, and
manage source code. The SDP takes advantage of these features of an SCM in your
CI/CD pipelines.

Currently, the preferred SCM is |GitHub|, which is where the SDP keeps and maintains its
source code. Other Git-based SCMS like GitLab are also viable, as are other SCMs
like Mercurial, but the SDP libraries to support them have not yet been created.

=========================
Understand Your Pipeline
=========================

A basic DevSecOps, CI/CD Pipeline will do three things: build, deploy, and test.
It should take the raw source code and change it to a format that will run
optimally on your platform, it should take the output of the build and
deploy it to your platform, and all throughout it should be automatically testing various
aspects of the application - anything from unit tests to penetration tests.

There are myriad ways to do any of these three tasks, but since it's assumed you'll
be deploying on Openshift, we can make some assumptions about your pipeline.

--------
Building
--------

Since Openshift is a container application platform, and it's assumed that your
application is being deployed to Openshift, it can also be assumed that your application
running as (Docker) containers. The SDP's |docker_library| makes it easy to
build images from your source code repository and store them in Openshift's
built-in |container_registry|.

.. important::

   Openshift has some guidelines around container images that it's important
   to be aware of. The section on supporting arbitrary user IDs is particularly
   importatant.

-------
Testing
-------

The SDP currently has libraries for tools that run |code_quality_tests|,
|accessibility_compliance_tests|, |penetration_tests| and more. Which ones you should
use depends on the needs of your application. Automated tests are useful for
detecting issues earlier in a feature's lifecycle, where it's easier (and
cheaper) to correct.

---------
Deploying
---------

The |openshift_library| makes it easy to deploy to different Openshift projects
using |helm| a Kubernetes/Openshift package manager and templating tool. How to
deploy an application is defined in a helm chart or charts, which is maintained
in your SCM alongside your source code and pipeline configuration. This is covered
in greater detail in Section 3.



.. |GitHub| raw:: html

   <a href="https://github.com/" target="_blank">GitHub</a>

.. |docker_library| raw:: html

   <a href="/pages/libraries/docker/README.html" target="_blank">docker library</a>

.. |Gradle_Build_Tool| raw:: html

   <a href="https://gradle.org/" target="_blank">Gradle Build Tool</a>

.. |code_quality_tests| raw:: html

   <a href="/pages/libraries/sonarqube/README.html" target="_blank">code quality tests</a>

.. |accessibility_compliance_tests| raw:: html

   <a href="/pages/libraries/a11y/README.html" target="_blank">accessibility compliance (508) tests</a>

.. |penetration_tests| raw:: html

   <a href="/pages/libraries/owasp_zap/README.html" target="_blank">penetration tests</a>
