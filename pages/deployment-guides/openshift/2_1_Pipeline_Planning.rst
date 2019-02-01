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

Currently the SDP supports building applications as Docker containers through
the |docker_library|.

-------
Testing
-------

The SDP currently has libraries for tools that run |code_quality_tests|,
|accessibility_compliance_tests|, |penetration_tests| and more. What you should
use depends on the needs of your application, but automated tests ensure that
problems are detected earlier in a feature's lifecycle, where it's easier (and
cheaper) to correct.

---------
Deploying
---------




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
