#!/bin/sh
docker stop $(docker ps -aq --filter ancestor=myjenkins)
docker rm -f $(docker ps -aq --filter ancestor=myjenkins)
docker rmi -f $(docker images -aq --filter reference=myjenkins)


