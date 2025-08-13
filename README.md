
[![build docker images - janus-webrtc-docker](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/prod-docker-image.yml/badge.svg)](https://github.com/wangsrGit119/janus-webrtc-gateway-docker/actions/workflows/prod-docker-image.yml)

> ⚠️ **Warning**  
> If you need Janus 0.x support, please visit [janus-webrtc-gateway-docker-0.x](https://github.com/atyenoria/janus-webrtc-gateway-docker)

## Project Overview

This project provides a Docker image for Janus WebRTC Gateway, making deployment and integration fast and simple. The image is based on the official Janus source code, with unnecessary modules removed, multi-platform support enabled, and optional Nginx startup.

## Official Janus Repository

- [meetecho/janus-gateway](https://github.com/meetecho/janus-gateway.git "janus:1.0")

> 🚀 Continuous integration and automated Docker image publishing are powered by GitHub Actions.

## Base Image Source

This repository is based on [atyenoria/janus-webrtc-gateway-docker](https://github.com/atyenoria/janus-webrtc-gateway-docker), with the following improvements:
- ⬆️ Updated Janus version
- 🗑️ Removed nginx-rtmp-module
- 🏗️ Enhanced multi-platform support

## Image Versions and Platform Support

- 🆙 **From version 1.3.1 onwards**: Multi-platform (x86_64 and arm64) images are merged, so pulling the same tag will automatically match your platform—no need to distinguish between architectures.
- ⏪ **For 1.3.0 and below**: x86_64 and arm64 images are published separately; you must manually pull the image matching your hardware.

### Version Mapping

| Docker Image Version        | Janus Version | Platform Support Description           |
|----------------------------|---------------|----------------------------------------|
| 1.2.0-slim/arm64 ~ 1.3.0-slim/arm64    | 1.2.0~1.3.0   | Separate x86_64/arm64 images           |
| 1.3.1 and above            | 1.3.1+        | Multi-platform merged image (recommended) |

## How to Use

1. **Prepare Configuration Files**  
   📂 Create a `conf` directory and place your Janus config files inside (see [official conf files](https://github.com/meetecho/janus-gateway/tree/master/conf) for reference).
2. **Write `docker-compose.yml`**  
   📝 Example configuration:

```yaml
services:
  janus-gateway:
    image: 'sucwangsr/janus-webrtc-gateway-docker:latest'
    # Only start janus
    #command: ["/usr/local/bin/janus", "-F", "/usr/local/etc/janus"]
    # Start nginx (port 8086) and janus together
    command: ["sh", "-c", "nginx && /usr/local/bin/janus -F /usr/local/etc/janus"]
    network_mode: "host"
    volumes:
      - "./conf/janus.transport.http.jcfg:/usr/local/etc/janus/janus.transport.http.jcfg"  # adminapi config
      - "./conf/janus.jcfg:/usr/local/etc/janus/janus.jcfg"
      - "./conf/janus.eventhandler.sampleevh.jcfg:/usr/local/etc/janus/janus.eventhandler.sampleevh.jcfg"
    restart: always
```

## Important Notes

- ⚠️ **Before starting, please make sure your configuration files are correct**, especially with respect to YAML formatting and comments.
- 🛠️ If you need to customize Janus features or plugins, refer to the official documentation and adjust the configuration as needed.
- 🛡️ If using `network_mode: "host"`, ensure the host machine ports are not occupied to avoid conflicts.
- 🏷️ For multi-platform images (1.3.1 and above), it is recommended to use the `:latest` or a specific version tag; Docker will auto-detect your hardware architecture.
- 🔄 For 1.3.0 and below, pull the `-slim` (x86_64) or `-arm64` image according to your hardware.

---

❓ For questions or feature requests, feel free to submit an Issue or PR!  
⭐ If you find this project helpful, please give it a Star!
