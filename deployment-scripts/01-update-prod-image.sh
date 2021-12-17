#!/bin/bash

# DESCRIPTION
#     Update production image (first locally and then on Docker Hub)
#
# NOTES
#     Before running the script make sure you have file 
#     "docker-hub-password.txt" containing a string with your Docker Hub 
#     password in the same directory as this script

set -eu 



# cd into root to get the project name from path
cd ..

PROJECT_NAME="$(basename "$PWD")"
read -p "Docker Hub username: " DOCKER_HUB_USERNAME



echo "==============================="
echo "=== Update production image ==="
echo "==============================="

echo

echo "1. Build production image"
# We have to include $DOCKER_HUB_USERNAME in image name because this is
# the convention used by Docker: it uses the part before "/" as Docker Hub 
# account username to find the place to upload the image to.

# Always execute 'docker build' command from the directory where your 
# Dockerfile, no matter what path you've provided to "-f". Otherwise you will
# get image build error.
cd ./node
docker build \
  -f ./Dockerfile.prod . \
  -t "$DOCKER_HUB_USERNAME/$PROJECT_NAME:latest"
cd ./../deployment-scripts

echo   

echo "2. Log in to Docker Hub"
cat ./docker-hub-password.txt | docker login --username "$DOCKER_HUB_USERNAME" --password-stdin 
   
echo
   
echo "3. Push production image to Docker Hub"
docker push "$DOCKER_HUB_USERNAME/$PROJECT_NAME:latest"

echo

echo "4. Log out of Docker Hub"
docker logout

echo

echo "Your local images related to this project:"
docker image ls | grep "$DOCKER_HUB_USERNAME/$PROJECT_NAME"

echo

echo "Production image has been updated successfully!"
