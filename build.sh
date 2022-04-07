#!/bin/bash

version=`date +%Y%m%d`

echo "build time $version , build version $version"
docker rmi $version
docker build -t janus-webrtc-gateway-docker:$version .
