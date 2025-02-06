#!/bin/bash

# Checks if a container name is supplied
if [ "$#" -eq 0 ]; then
    echo "Please specify a container name!"
    exit 1
fi

CONTAINER_NAME=$zer_bot

# Checks if the container exists
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "An existing container with the name $CONTAINER_NAME was found!"

    # Checks if the container is running and stops it if it is
    if [ "$(docker ps -q -f status=running -f name=$CONTAINER_NAME)" ]; then
        echo "Stopping container..."
        docker stop $CONTAINER_NAME
        echo "Container stopped."
    fi

    # Removes the stopped container
    echo "Removing stopped container..."
    docker rm $CONTAINER_NAME
    echo "Container removed."
fi

# Pulls the latest image
docker pull repo/image:master

# Runs a new Docker container
docker run -d --restart always --name $CONTAINER_NAME --env-file ./.env hanifsossou125/zer_bot:master
