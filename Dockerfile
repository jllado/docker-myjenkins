FROM jenkinsci/jenkins:2.63
MAINTAINER jllado

ARG DOCKER_GID=993

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

#Install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.11.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
  && chmod a+x /usr/local/bin/docker-compose

#Install nodejs & npm
RUN curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh && \
bash nodesource_setup.sh && \
apt-get install -yq nodejs build-essential

#Install mocha to run js tests
RUN npm install -g mocha

#Setup Maven
ENV MAVEN_VERSION 3.3.9

RUN curl -fsSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
COPY settings.xml /root/.m2/settings.xml

#Plugins
USER jenkins
COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN install-plugins.sh $(cat /usr/share/jenkins/plugins.txt | tr '\n' ' ')

#Set Defaults
ENV JENKINS_OPTS="--logfile=/var/log/jenkins/jenkins.log --prefix=/jenkins"
