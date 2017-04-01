#!/bin/sh
export DOCKER_GID=$(getent group docker | awk -F: '{printf $3}')
docker-compose -p myjenkins up -d
