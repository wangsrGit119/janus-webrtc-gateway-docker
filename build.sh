#!/bin/bash

version=`date +%Y%m%d`

echo "build time $version , build version $version"

docker build -t docker-webrtc-gateway:$version .
