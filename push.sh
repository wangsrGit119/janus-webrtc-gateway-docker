#!/bin/bash

version=`date +%Y%m%d`

echo "push time $version , push version $version"
docker login -u $1 -p $2
docker push janus-webrtc-gateway-docker:$version
docker logout
