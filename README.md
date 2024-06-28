
# janus-webrtc-gateway-docker
[![build docker images - janus-webrtc-docker](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/build-janus-gateway-docker-main.yml/badge.svg)](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/build-janus-gateway-docker-main.yml)

> **Warning**
>- if you want to use Janus 0.x please visit this repo [janus-webrtc-gateway-docker-0.x](https://github.com/atyenoria/janus-webrtc-gateway-docker)

## janus officia repository

[The official janus repository](https://github.com/meetecho/janus-gateway.git "janus:1.0")

>New version release depends on GitHub Action

## Base

modify :point_down: repo, and  update janus version , delete nginx-rtmp-module
> https://github.com/atyenoria/janus-webrtc-gateway-docker
> 

## amd image version

|  janus-webrtc-gateway-docker Version |  Janus Version |Desc|
| ------------ | ------------ |------------ |
|  20220407 |  1.0.0 |------------ |
|  20220617 | 1.0.1   |------------ |
|  20220618 | 1.0.2   |------------ |
|  20220627 | 1.0.3   |------------ |
|  20220813 | 1.0.4   |------------ |
|  20221018 | 1.1.0   |------------ |
|  20230108 | 1.1.1   |------------ |
|  20230127 | 1.1.2   |------------ |
|  20230320 | 1.1.3   |------------ |
|  20230829 | 1.1.4   |------------ |
|  1.2.0 | 1.2.0   | no Audio Bridge 、Lua、Duktape|
|  1.2.0-slim | 1.2.0   | with Audio Bridge plugin  |
|  1.2.1-slim | 1.2.1   | with Audio Bridge plugin  |
|  1.2.2-slim | 1.2.2   | with Audio Bridge plugin  |
|  1.2.3-slim | 1.2.3   | with Audio Bridge plugin  |
## arm64 images version

|  janus-webrtc-docker:version |  janus:version |
| ------------ | ------------ |
|  1.2.0-arm64 | 1.2.0   |
|  1.2.1-arm64 | 1.2.1  |
|  1.2.2-arm64 | 1.2.2  |
|  1.2.3-arm64 | 1.2.3  |


## How to use

 - mkdir conf ---- configs from [https://github.com/meetecho/janus-gateway/tree/master/conf](https://github.com/meetecho/janus-gateway/tree/master/conf)
 - touch docker-compose.yml --- content eg::point_down: 

```yaml
version: '3.3'
services:

  #
  # janus-gateway
  #
  janus-gateway:
    image: 'sucwangsr/janus-webrtc-gateway-docker:1.2.3-slim'
    #command: ["/usr/local/bin/janus", "-F", "/usr/local/etc/janus"] # only start janus 
    command: sh -c "nginx && /usr/local/bin/janus -F /usr/local/etc/janus  # if want to start nginx (port 8086)
    network_mode: "host"
    
    volumes:
      - "./conf/janus.transport.http.jcfg:/usr/local/etc/janus/janus.transport.http.jcfg"  # open adminapi config
      - "./conf/janus.jcfg:/usr/local/etc/janus/janus.jcfg"
      - "./conf/janus.eventhandler.sampleevh.jcfg:/usr/local/etc/janus/janus.eventhandler.sampleevh.jcfg"
    restart: always

```

>**Warning**
> Before startup, please ensure your config files is ok,  pay attention to comments in YAML
