.. _configuration_of_sdp:

####################
Configuration of SDP
####################

Recap
=====

At this point, you should have deployed and configured your Jenkins instance as
well as installed the JTE plugin.


Overview
========

In this section of the Getting Started Guide, you will setup and configure a
basic Jenkins pipeline for the different repositories in your GitHub Organization.


Identify the Source Code
========================

It wouldn't be much of a pipeline if there wasn't any code to send through it.
You can use your own source code so long as can be compiled/built with
``docker build``. If you don't yet have a compatible source code repository, you
can fork this `example project`_ for the purposes of this Getting Started Guide.

.. _example project: https://github.com/kottoson-bah/sdp-example-proj

For simplicity, and because of its popularity, the rest of this guide will
assume GitHub is the source code management tool (SCM) being used. It's also
assumed that Docker is being used to containerize and run the source code. This
guide will make an attempt to explain *how* these tools are being used, so that
the reader might be able to identify parallels in their own set of tools.


Create a Pipeline Configuration Repository
==========================================

There needs to be *someplace* to store and organize the pipeline templates and
configuration files that the JTE uses. We use a code repository since Jenkins
has the tools to fetch, navigate, and use the files managed by an SCM.


Create the Repository
----------------------

The logical place to do this is alongside your project's other source-code
repositories. In GitHub, this usually means creating it in the same
Organization. If your project is spread across multiple Organizations,
identify one that makes sense to use or create a new one. If all of your
repositories are under your account, and not in an organization, your username is
the functional organization name. A good name for this repository you create is
"pipeline-config," but you can name it anything. What's important is that the
SDP's configuration files are somewhere easily found and managed by you and your
team.


Add a pipeline_config.groovy file
---------------------------------

While a pipeline_config.groovy file is not strictly required - the JTE uses a
`base pipeline config file`_ with sensible defaults - it's a good idea to create
the file now. Should you want to add to it later, it will be there and ready for
you to add changes.

.. _base pipeline config file: https://github.com/boozallen/sdp-pipeline-framework/blob/master/resources/sdp/pipeline_config.groovy


For this Getting Started Guide, it is assumed your project's application runs
inside containers. This means that, at a bare minimum, your pipeline builds
and pushes a (Docker) container image. In order to do that, we need a pipeline
config file set up to use Docker and our SCM (GitHub).

In the root of your repository we just created, create a new file called
pipeline_config.groovy and add to it the following:

.. code-block:: groovy

    application_image_repository = "docker-registry.default.svc:5000/demo"
    application_image_repository_credential = "docker-registry"

    libraries{
      github_enterprise
      docker
    }


The first two fields inform the SDP where we want to store our application's
container images. This is how the Docker SDP library knows where to push the
images it builds.

.. note::

    If you don't have a docker registry to store images in, you can
    `deploy one locally`_. If you go this route, set ``application_image_repository``
    to ``127.0.0.1:5000`` or the IP address of the container, depending on how
    you're running Jenkins. Note that if you don't add a signed ssl certificate
    to your registry you'll need to `add your registry's IP and port to your
    Docker daemon's list of trusted registries`_.

..  _add your registry's IP and port to your Docker daemon's list of trusted registries: https://docs.docker.com/registry/insecure/#deploy-a-plain-http-registry

.. _deploy one locally: https://docs.docker.com/registry/deploying/

The ``application_image_repository`` field identifies the *hostname* and
*namespace* of the repositories used to store and retrieve application images.
This is prepended to an image's (repo) name and tag to create the full image name.

The ``application_image_repository_credential`` is the ID of the credential
stored in Jenkins used to login to that repository. We create this credential
later on in this guide, but note that this ID is an arbitrary name.

Under ``libraries{}`` there are two SDP libraries listed: ``github_enterprise``
and ``docker``. We will be using the pipeline steps provided by the Docker
library in the pipeline, and we include the GitHub Enterprise library because
it is a dependency of the Docker library. A list of pipeline libraries can be
found `on the Pipeline Libraries page`_

.. _on the Pipeline Libraries page: /pages/libraries/index.html

.. note::

   Although the library name is "github_enterprise," it will work with the
   repositories on `public GitHub`_ as well.

.. _public GitHub: https://github.com

Add a Jenkinsfile
-----------------

In addition to our pipeline configuration file, we want to add a default
pipeline template, "Jenkinsfile". Unless specified otherwise in our pipeline
config file(s), every pipeline we run will execute the steps in this file.

Create a file called Jenkinsfile and inside put one line: ``build()``. Now,
every pipeline that uses this default template will execute the "build" step,
which is provided by the "docker" library we specified in the pipeline config
file. This step should build a container image from source code and push it to
the application image repository defined within the ``pipeline_config.groovy`` file.


Configure Your Organization in Jenkins
======================================

For this section of the guide, we will use the *pipeline configuration* repository
we created to setup pipelines for *source code* repositories within a single
GitHub Organization. If you have just a single source code repository, you may
opt to use a *Multibranch Pipeline* instead. If you have multiple GitHub
Organziations, you can repeat this section of the guide for each. You don't need
a separate pipeline config repo for each Organization and/or code repository.


Add Credentials
---------------

.. note::

  In this Getting Started Guide we will cover how to create
  *global credentials*. If you want to create credentials in different domains
  with different scopes, be sure that the relevant Jenkins projects have access.

Assuming this hasn't already been done, you will need to create two credentials
in Jenkins' Credentials Store, one for your SCM and another for your application
image repository. From the Jenkins homepage, go to Credentials -> System, click
"Global credentials (unrestricted)," then "Add Credentials."

The SDP, and the github_enterprise library in particular, requires a credential that can be
used to access the source code repositories. *Presumably*, we can also use this to
fetch our pipeline configuration repository. Enter a GitHub username in the
*Username* field, its password in the *Password* field, and a descriptive name (like "github") in the
*ID* and *Description* fields. Click OK to submit.

Next we need the "docker-registry" credential we specified in our
pipeline config file for the Docker registry. Click "Add
Credentials" again. Enter a username and password in the corresponding fields,
and put "docker-registry" in the *ID* and *Description* fields.

.. TODO: Add links for info about usernames/passwords for different registries (i.e. the Openshift default registry)

.. note::

    If your application image repository doesn't require a username/password,
    you still need to create a credential to use. Just set both the username
    and password to **unused**.

Add a GitHub Organization Project to Jenkins
--------------------------------------------

So far we've created a pipeline config file (pipeline_config.groovy), a default
pipeline template (Jenkinsfile), and added the two credentials we'll need to
the Jenkins credentials store (github & docker-registry). The next
step is to start populating Jenkins with pipelines to run.

In the Jenkins homepage, click "New Item," enter a name for your project (such
as the name of the GitHub organization it'll represent),
select "GitHub Organization," then click OK. This will take you to the
configuration page for your new GitHub Organization project.

Starting in the *Projects* section, choose the "github" credential we created in
the *Credentials* field, set the *Owner* field to the name of the GitHub
organization (or name of the account) containing the source code repositories to
build from. In the *Project Recognizers* sub-section, using the red **X** delete
the *Pipeline Jenkinsfile* block. Then, using the *Add* dropdown, add a *Jenkins
Templating Engine* block.

Scroll down to the *Solutions Delivery Platform* section and, in the *Source
Location* dropdown, select "Git." In the *Repository URL* section, add your
pipeline config repo's URL. This is the same URL you would use to clone it,
which you can get by accessing to the repo online, clicking the "Clone or download"
button, and copying the (http or https) URL. If there's a "Failed to connect"
error message, don't panic. Select your GitHub credential for the
*Credentials* section and that should disappear.

.. note::

    If you're using GitHub Enterprise, you'll need to add a GitHub
    Enterprise Server in your Jenkins configuration if you haven't already.
    You'll also need to set any *API endpoint* to your GitHub Enterprise server's
    API endpoint.

Move down to the *Library Sources* section and click add. A *Library* block
should pop up. In the *SCM* dropdown select "Git." You should have access to
an |sdp-libraries| repository. Put the URL for that repository in the *Repository
URL* section, and again use your github credential in the *Credentials* section.

.. |sdp-libraries| raw:: html

    <a href="https://github.com/boozallen/sdp-libraries" target="_blank">sdp-libraries</a>


Double-check your settings, then hit *Save*. Jenkins will start scanning your
GitHub Organization for repositories. Clicking *Status* in the top right should
show you a list of the repositories in your Organization.

.. note::

    If you have multiple organizations you wish to build from, add additional
    GitHub Organization projects and configure them the same way.


Final Touches
=============

If you've followed all of the previous sections, you should now have a basic
build pipeline. All that's left is to watch it run and to automate it.


Watch The Pipeline Run
----------------------

In Jenkins, from your GitHub Organization Project, click on one of your source
code repositories (one with a Dockerfile), select a branch, and click *Build
Now*. You should see a build start and, after a bit, finish successfully. Once it
finishes, a new image should be in the **application_image_repository** you set
in your pipeline config. It'll have the repository in the image name, and the tag will
be the Git SHA for the latest commit of that repository's branch (i.e. the
HEAD).

Automate The Pipeline
---------------------

.. note::

   You cannot do this particular step if your Jenkins server doesn't have a public
   URL (i.e. if your Jenkins URL is http://localhost:8080)

We've proven that the pipeline finishes successfully (at least for the
repository we just tested). Now we want the pipeline to run automatically
whenever a new commit is pushed to the repository. This way, we have a built
container image with the latest features as soon as they get pushed to
GitHub.

You can configure webhooks for the entire GitHub Organization or for each
repository individually. For whichever you choose, go to its settings page,
select *Hooks*, and click the *Add webhook* button in the top right. The
*Payload URL* is your Jenkins URL **plus** ``/github-webhook/``
(i.e. https://my-jenkins.example.com/github-webhook/). Don't change
*Content type* or *Secret*. Choose "Let me select individual events" and check
"Pull Requests," "Pushes," and "Repositories."

Once you click "Add webhook," GitHub will test that your webhooks can reach the
Jenkins server. If that succeeds, you're all set! Make a commit to your
repository and, in a moment, you should see Jenkins automatically start a
corresponding build.
