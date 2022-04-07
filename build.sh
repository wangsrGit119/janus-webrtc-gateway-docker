#!/bin/bash

version=`date +%Y%m%d`

echo "build time $version , build version $version"
docker rmi $version
docker build -t sucwangsr/janus-webrtc-gateway-docker:$version .
