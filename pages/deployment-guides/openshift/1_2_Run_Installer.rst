Section 1.2 - Running the Installer Script
====================================

========================
Run the Installer Script
========================

From the root of the sdp-helm-chart directory, run the command

::

  ./installer.sh

Supply a GitHub username and password (or access token) when prompted.

Should the installer script fail, see if you can use the error message to
resolve the issue and try running the script again. If you can't, go to the previous
pages of the guide and make sure the prerequisites are met and the steps were
completed.

.. Go to an FAQ when there is one, a forum should we create one, or the issues page on GitHub ?

After the SDP has successfully been installed, you should see the message

::

  Successfully Installed the Solutions Delivery Platform.

  ✔ Solutions Delivery Platform Installed

While the SDP has been installed on Openshift, it needs a few minutes to
prepare and set up. Go to the overview page for the "sdp" project in your
OpenShift cluster's web console to monitor the progress. The overview page
should also show the links for Jenkins and any other tools you opted to install.

=======================
Verify the Installation
=======================

After a few minutes, Jenkins should finish setting up. On the overview page for
the "sdp" project you should see all blue rings showing all of the pods are
running successfully. When you click on the
Jenkins link - it'll be something like http://jenkins.app.ocp.example.com - you
should be redirected to an OpenShift login page. Use your Openshift credentials
to log in. If you're prompted to allow the jenkins Service Account to
access your account, click "Allow selected permissions" to proceed. You should
see a fresh Jenkins ready for new jobs.

If you installed Sonarqube, you should be able to click on the link - it'll be
something like http://sonarqube.apps.ocp-dev.microcaas.net - and go to the
Sonarqube homepage. Log in with the username and password "admin" and optionally
skip the tutorial. You should be an empty Sonarqube ready to analyze

==========
Next Steps
==========

If all you need is Jenkins and the DevOps tools, you should be finished. Jenkins
has the JTE and a number of standard plugins installed for you.

Continue on to the following sections to walk through creating a CI/CD pipeline
using the SDP to automatically deploy your applications to Openshift.
