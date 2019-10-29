# Copyright © 2018 Booz Allen Hamilton. All Rights Reserved.
# This software package is licensed under the Booz Allen Public License. The license can be found in the License file or at http://boozallen.github.io/licenses/bapl

FROM sonarqube:6.7

ENV PLUGINS $SONARQUBE_HOME/extensions/plugins

ADD run.sh $SONARQUBE_HOME/bin/run.sh
ADD sonar.properties /opt/sonarqube/conf/sonar.properties

USER root
RUN curl -L -O https://binaries.sonarsource.com/Distribution/sonar-java-plugin/sonar-java-plugin-5.1.0.13090.jar && \
    curl -L -O https://github.com/SonarQubeCommunity/sonar-pmd/releases/download/2.6/sonar-pmd-plugin-2.6.jar && \
    curl -L -O https://github.com/checkstyle/sonar-checkstyle/releases/download/4.8/checkstyle-sonar-plugin-4.8.jar && \
    curl -L -O https://github.com/spotbugs/sonar-findbugs/releases/download/3.6.0/sonar-findbugs-plugin-3.6.0.jar && \
    curl -L -O https://binaries.sonarsource.com/Distribution/sonar-javascript-plugin/sonar-javascript-plugin-4.0.0.5862.jar && \
    curl -L -O https://binaries.sonarsource.com/Distribution/sonar-auth-github-plugin/sonar-auth-github-plugin-1.3.jar && \
    mv $SONARQUBE_HOME/*.jar $PLUGINS && \
    chmod +x $SONARQUBE_HOME/bin/run.sh && \
    chown -R sonarqube $SONARQUBE_HOME && \
    chgrp -R 0 $SONARQUBE_HOME && \
    chmod -R g+rw $SONARQUBE_HOME && \
    find $SONARQUBE_HOME -type d -exec chmod g+x {} +


USER sonarqube
ENTRYPOINT $SONARQUBE_HOME/bin/run.sh

