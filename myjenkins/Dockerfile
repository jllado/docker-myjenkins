FROM jenkins:2.32.2
MAINTAINER jllado

ARG DOCKER_GID=993

#Prepare Jenkins Directories
USER root
RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

#Prepare image to execute docker cli
RUN groupadd -g ${DOCKER_GID} docker
RUN usermod -aG docker jenkins 
RUN apt-get update \
    && apt-get install -y sudo \
    && rm -rf /var/lib/apt/lists/*
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

USER jenkins

#Set Defaults
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"
