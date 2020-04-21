FROM jenkins/jenkins:2.204.4-jdk11
MAINTAINER jllado

ARG DOCKER_GID

#skip wizzard
RUN echo 2.204.4 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state
RUN echo 2.204.4 > /usr/share/jenkins/ref/jenkins.install.InstallUtil.lastExecVersion

#Jenkins Directories
USER root
RUN mkdir /var/log/jenkins
RUN chown -R jenkins:jenkins /var/log/jenkins

#docker cli
ENV DOCKER_VERSION 19.03.3
ENV COMPOSE_VERSION 1.23.1
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common 
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
RUN apt-get update  -qq \
    && apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-Linux-x86_64 > /usr/local/bin/docker-compose \
 && chmod +x /usr/local/bin/docker-compose
RUN usermod -aG docker jenkins 
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers

#kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin
USER jenkins
RUN mkdir /var/jenkins_home/minikube
VOLUME /var/jenkins_home/minikube

#Plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

#Set Defaults
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"

ENV JENKINS_USER admin
ENV JENKINS_PASS admin
COPY basic-security.groovy /usr/share/jenkins/ref/init.groovy.d/
