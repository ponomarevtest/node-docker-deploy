#!/bin/bash

echo "*** Start deployment ***"

cd /home/andrey

# Later use only 'git pull' to update repo
echo "1. Clone Git repo"
git clone https://github.com/ponomarevtest/node-docker-deploy.git
cd node-docker-deploy

echo

echo "Run app"
docker-compose up --build
