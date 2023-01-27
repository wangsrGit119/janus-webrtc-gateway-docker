
# janus-webrtc-gateway-docker
[![build docker images - janus-webrtc-docker](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/build-janus-gateway-docker-main.yml/badge.svg)](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/build-janus-gateway-docker-main.yml)

> **Warning**
>- if you want to use Janus 0.x please visit this repo [janus-webrtc-gateway-docker-0.x](https://github.com/atyenoria/janus-webrtc-gateway-docker)
## janus 1.x

[janus address](https://github.com/meetecho/janus-gateway.git "janus:1.0")

> release repo  to docker hub by github action

## base

modify :point_down: repo, and  update janus version , delete nginx-rtmp-module
> https://github.com/atyenoria/janus-webrtc-gateway-docker
> 

## image version

|  janus-webrtc-docker:version |  janus:version |
| ------------ | ------------ |
|  20220407 |  1.0.0 |
|  20220617 | 1.0.1   |
|  20220618 | 1.0.2   |
|  20220627 | 1.0.3   |
|  20220813 | 1.0.4   |
|  20221018 | 1.1.0   |
|  20230108 | 1.1.1   |
|  20230127 | 1.1.2   |
## how to use

 - mkdir conf ---- configs from [https://github.com/meetecho/janus-gateway/tree/master/conf](https://github.com/meetecho/janus-gateway/tree/master/conf)
 - touch docker-compose.yml --- content eg::point_down: 

```yaml
version: '1.1.2'
services:

  #
  # janus-gateway
  #
  janus-gateway:
    image: 'sucwangsr/janus-webrtc-gateway-docker:20230127'
    command: ["/usr/local/bin/janus", "-F", "/usr/local/etc/janus"]
    network_mode: "host"
    
    volumes:
      - "./conf/janus.transport.http.jcfg:/usr/local/etc/janus/janus.transport.http.jcfg"  # open adminapi config
      - "./conf/janus.jcfg:/usr/local/etc/janus/janus.jcfg"
      - "./conf/janus.eventhandler.sampleevh.jcfg:/usr/local/etc/janus/janus.eventhandler.sampleevh.jcfg"
    restart: always


```
