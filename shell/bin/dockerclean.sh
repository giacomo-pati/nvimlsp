#!/bin/sh

echo docker image prune -f -a
docker image prune -f -a
echo docker container prune -f
docker container prune -f
echo docker volume prune -f -a
docker volume prune -f -a
echo docker network prune -f
docker network prune -f
