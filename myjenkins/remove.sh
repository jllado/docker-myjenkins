#!/bin/sh
if [ $(docker ps -aq --filter ancestor=myjenkins) ]; then
    docker stop $(docker ps -aq --filter ancestor=myjenkins)
    docker rm -f $(docker ps -aq --filter ancestor=myjenkins)
fi
if [ $(docker images -aq --filter reference=myjenkins) ]; then
    docker rmi -f $(docker images -aq --filter reference=myjenkins)
else
    echo Already removed!
fi


