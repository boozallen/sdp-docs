.. _Understanding the Jenkinsfile

-----------------------------
Understanding the Jenkinsfile
-----------------------------

Now that you have a general understanding of what we did within the sample `pipeline_config.groovy`_ file
we created for you, we'll be going over the `Jenkinsfile`_ we created, or what we like to call the **pipeline template**, that we placed inside
the sample code application GitHub repository.

.. _pipeline_config.groovy: https://github.com/boozallen/sdp-labs-sample-app/blob/master/pipeline_config.groovy

The contents of the Jenkinsfile is shown below:

.. code-block:: bash

    static_code_analysis()
    build()

As you can see, there are only two lines. Each line consists of a `Jenkins step`_, which just tells Jenkins what the pipeline needs
to do in order to be successful, and they are each derived from the SDP-created `SonarQube`_ and `Docker`_ libraries.

The ``static_code_analysis()`` is derived from the `SonarQube`_ library. It simply tells the pipeline to perform some code analysis
using the SonarQube server that we deployed earlier. Since this Jenkins step is derived from the SonarQube library, we needed to put
``sonarqube`` as a library within the pipeline_config.groovy file earlier.

After the ``static_code_analysis()`` is performed, the ``build`` step from the `Docker`_ library is run. It tells the pipeline to build a Docker
image (assuming that the respective application's GitHub repository contains a Dockerfile) and pushes it to the URL of the ``registry``
defined within the Docker block within the pipeline_config.groovy, which we defined on the previous page.

When the Jenkins pipeline is able to successfully complete both steps, then there will a successful build where a user can view a 
SonarQube report of the sample code and pull a finished Docker image of the sample Spring Boot API code from their local Docker registry.

.. _SonarQube: https://boozallen.github.io/sdp-docs/pages/libraries/sonarqube/README.html

.. _Docker: https://boozallen.github.io/sdp-docs/pages/libraries/docker/README.html

.. _Jenkins step: https://jenkins.io/doc/book/pipeline/syntax/

.. _Jenkinsfile: https://github.com/boozallen/sdp-labs-sample-app/blob/master/Jenkinsfile