#!/bin/sh
docker build --build-arg DOCKER_GID=$(getent group docker | awk -F: '{printf $3}') -t myjenkins .
docker run -p 7070:8080 -v /opt/servers/jenkins:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -v $(which docker):/usr/bin/docker --name=myjenkins -d myjenkins

