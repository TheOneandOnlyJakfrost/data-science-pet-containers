#! /bin/bash

sudo podman rm --force `sudo podman ps -aq`
sudo docker rm --force `sudo docker ps -aq`
sudo docker network rm dspc
sudo docker network create --driver bridge dspc
sudo docker run --network dspc --detach --env-file .env \
  --hostname postgis --name postgis --publish 5439:5432 \
  postgis:latest
sudo docker run --network dspc --detach --env-file .env \
  --hostname rstats --name rstats --publish 8004:8004 \
  rstats:latest
sudo docker run --network dspc --detach --env-file .env \
  --hostname pgadmin4 --name pgadmin4 --publish 8686:80 \
  docker.io/dpage/pgadmin4:latest
sudo docker ps
sudo docker exec -u rstats rstats /home/rstats/scripts/is_postgis_there.R
