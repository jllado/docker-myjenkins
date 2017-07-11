FROM jenkinsci/jenkins:2.67
MAINTAINER jllado

ARG DOCKER_GID

#Prepare Jenkins Directories
USER root
RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

#Prepare image to execute docker cli
RUN groupadd -g $DOCKER_GID docker
RUN usermod -aG docker jenkins 
RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#Install nodejs & npm
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
bash nodesource_setup.sh && \
apt-get install -yq nodejs build-essential

#Install mocha to run js tests
RUN npm install -g mocha

#Plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')

#Set Defaults
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

ENV JENKINS_USER admin
ENV JENKINS_PASS admin
COPY default-user.groovy /usr/share/jenkins/ref/init.groovy.d/
