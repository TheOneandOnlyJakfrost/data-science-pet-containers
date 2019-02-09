#! /bin/bash

sudo docker build --tag rstats:latest --file Dockerfile.opencpu .
sudo docker build --tag rstatsp:latest --file Dockerfile.opencpu-preview .
sudo docker build --tag postgis:latest --file Dockerfile.postgis .
sudo docker pull docker.io/dpage/pgadmin4:latest
sudo docker images
