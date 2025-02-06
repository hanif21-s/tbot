#!/bin/bash

CID=$(docker ps -a --filter "publish=8002" --format="{{.ID}}")
echo "Container ID: $CID"
if [ -n "$CID" ]; then
  docker stop $CID
  docker rm $CID
fi