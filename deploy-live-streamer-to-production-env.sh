#!/bin/bash

"*** Start deployment ***"

cd /home/andrey

echo "1. Clone Git repo"

git clone https://github.com/ponomarevtest/node-docker-deploy.git
cd node-docker-deploy

echo

echo "2. Copy .env file from local machine to VPS"
scp ./node/.env root@85.143.217.174:/home/andrey/node-docker-deploy/node

echo

echo "Run app"
docker-compose up --build
