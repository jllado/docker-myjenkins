#!/bin/sh
mkdir -p /opt/servers/jenkins/
chmod a+xwr -R /opt/servers/jenkins/
export DOCKER_GID=$(getent group docker | awk -F: '{printf $3}')
docker-compose -p myjenkins up -d --build
