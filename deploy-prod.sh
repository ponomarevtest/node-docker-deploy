#!/bin/bash

"*** Start deployment ***"

cd /home/andrey

echo "1. Clone Git repo"

git clone https://github.com/ponomarevtest/node-docker-deploy.git

echo

echo "Run app"
docker-compose up --build
