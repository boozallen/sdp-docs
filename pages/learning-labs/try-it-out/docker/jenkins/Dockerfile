# Copyright © 2018 Booz Allen Hamilton. All Rights Reserved.
# This software package is licensed under the Booz Allen Public License. The license can be found in the License file or at http://boozallen.github.io/licenses/bapl

FROM jenkins/jenkins:2.150.1

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"

EXPOSE 8080
EXPOSE 50000

USER root

# copy in custom common-workflow plugin
# COPY resources/plugins/jte.jpi /usr/share/jenkins/ref/plugins/jte.jpi
ADD https://github.com/boozallen/jenkins-templating-engine/releases/download/v0.1-alpha/jte.jpi /usr/share/jenkins/ref/plugins/jte.jpi

# install plugins 
COPY resources/plugins/plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# insert job dsl scripts
RUN mkdir -p /var/jenkins_home/init.jobdsl.d
COPY resources/jobs/* /var/jenkins_home/init.jobdsl.d/
RUN chmod 777 /var/jenkins_home/init.jobdsl.d/*

# copy in entry point scripts
COPY resources/scripts/jenkins.sh /usr/local/bin/jenkins.sh
RUN chmod 777 /usr/local/bin/jenkins.sh

# copy in casc plugin 
ENV CASC_JENKINS_CONFIG /usr/share/jenkins/ref/casc_configs/jenkins.yaml
COPY resources/jenkins.yaml /usr/share/jenkins/ref/casc_configs/jenkins.yaml

# copy in groovy init scripts 
ENV INIT_GROOVY_DIR /usr/share/jenkins/ref/init_groovy
COPY resources/scripts/init_groovy /usr/share/jenkins/ref/init_groovy