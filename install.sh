#!/bin/sh
mkdir -p /opt/servers/jenkins/
sudo chown -R $USER /opt/servers/jenkins/
cp -R .kube /opt/servers/jenkins/.kube
export DOCKER_GID=$(getent group docker | awk -F: '{printf $3}')
export KUBERNETES_SERVER=$(sudo minikube ip)
docker-compose -p myjenkins up -d --build
