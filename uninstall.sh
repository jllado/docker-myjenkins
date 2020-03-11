#!/bin/sh
docker-compose -p myjenkins down
#rm -rf /opt/servers/jenkins
if [ $(docker images -aq --filter reference=myjenkins_jenkins) ]; then
    docker rmi -f $(docker images -aq --filter reference=myjenkins_jenkins)
else
    echo Already removed!
fi


