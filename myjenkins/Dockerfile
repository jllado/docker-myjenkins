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

#Plugins
USER jenkins
#COPY plugins.txt /usr/share/jenkins/plugins.txt
#RUN cd /usr/share/jenkins/ref/plugins/; install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')

#Set Defaults
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"
