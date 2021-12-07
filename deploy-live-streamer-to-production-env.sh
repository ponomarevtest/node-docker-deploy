#!/bin/bash

echo "*** Start deployment ***"

cd /home/andrey

# Before this step you have to manually 'git clone' the repo, when you deploy for the first time
echo "1. Clone Git repo"
git pull https://github.com/ponomarevtest/node-docker-deploy.git
cd node-docker-deploy

echo

echo "Run app"
docker-compose up --build
