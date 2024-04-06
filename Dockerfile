FROM ubuntu:22.04

ENV DEBIAN_FRONTEND noninteractive
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get -y update && apt-get install -y \
    libjansson-dev \
    libnice-dev \
    libssl-dev \
    libsofia-sip-ua-dev \
    libglib2.0-dev \
    zlib1g-dev \
    libopus-dev \
    libspeexdsp-dev \
    libogg-dev \
     libcurl4-openssl-dev \
    libini-config-dev \
    libcollection-dev \
    libconfig-dev \
    pkg-config \
    gengetopt \
    libtool \
    autopoint \
    automake \
    build-essential \
    subversion \
    git \
    cmake \
    unzip \
    zip \
    g++ \
    gcc \
    libc6-dev \
    make \
    pkg-config \
    lsof wget vim sudo rsync cron mysql-client openssh-server supervisor locate mplayer valgrind certbot curl dnsutils tcpdump gstreamer1.0-tools
    


# libwebsockets
RUN cd /tmp/ &&  LIBWEBSOCKET="4.3.2" && wget https://github.com/warmcat/libwebsockets/archive/v$LIBWEBSOCKET.tar.gz && \
    tar xzvf v$LIBWEBSOCKET.tar.gz && \
    cd libwebsockets-$LIBWEBSOCKET && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" -DLWS_MAX_SMP=1 -DLWS_IPV6="ON" .. && \
    make && make install

# libsrtp
RUN cd /tmp/ && SRTP="2.2.0" && wget https://github.com/cisco/libsrtp/archive/v$SRTP.tar.gz && \
    tar xfv v$SRTP.tar.gz && \
    cd libsrtp-$SRTP && \
    ./configure --prefix=/usr --enable-openssl && \
    make shared_library && sudo make install



# libnice 0.1.21    commit 3d9cae16a5094aadb1651572644cb5786a8b4e2d
RUN cd / && apt-get remove -y libnice-dev libnice10 && apt-get update -y && apt-get install -y python3-pip ninja-build  && pip3 install meson && \
    git clone https://gitlab.freedesktop.org/libnice/libnice.git && \
    cd libnice && \
    git checkout 3d9cae16a5094aadb1651572644cb5786a8b4e2d && \
    meson --prefix=/usr build && \
    ninja -C build && \
    sudo ninja -C build install


# datachannel build
RUN cd / && git clone https://github.com/sctplab/usrsctp && \
cd usrsctp && \
./bootstrap && \
./configure --prefix=/usr --disable-programs --disable-inet --disable-inet6 && \
make && sudo make install

# libmicrohttpd v0.9.72
RUN apt-get update && apt-get install -y autoconf texinfo automake && \
	cd /tmp && git clone https://git.gnunet.org/libmicrohttpd.git && \
	cd libmicrohttpd && git checkout v0.9.72 && autoreconf -fi && \
	./configure --prefix=/usr --enable-messages --enable-https && make && make install


# lua for plugin  Lua
RUN curl -L -R -O https://www.lua.org/ftp/lua-5.4.6.tar.gz \
    && tar zxf lua-5.4.6.tar.gz \
    && cd lua-5.4.6 \
    && make all test \
    && make install \ 
    && lua -v
    
# for duktape plugin
RUN cd /tmp/ && curl -R -O https://duktape.org/duktape-2.7.0.tar.xz \
    && tar xf duktape-2.7.0.tar.xz \
    && mv duktape-2.7.0 / && cd /duktape-2.7.0  \
    && make -f Makefile.cmdline \
    && ln -s /duktape-2.7.0/duk /usr/local/bin/duk \
    && duk
    

  
## janus if build use --enable-post-processing
RUN apt-get update -y && apt-get install libavutil56 libavcodec58 libavformat58 libavutil-dev libavcodec-dev libavformat-dev -y


# janus
RUN cd / &&  git clone https://github.com/meetecho/janus-gateway.git && cd /janus-gateway && \
    git checkout refs/tags/v1.2.2 && \
    sh autogen.sh &&  \
    ./configure --prefix=/usr/local \
	--enable-post-processing \
    --disable-rabbitmq \
    --disable-mqtt \
    --disable-unix-sockets \
    --enable-all-handlers && \
    make && make install && make configs


#FFmpeg install
RUN apt update -y && sudo apt install  -y ffmpeg && ffmpeg -version

# nginx
RUN apt-get update -y && apt-get install -y nginx
COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get clean && \
	rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-l", "-euxo", "pipefail", "-c"]

CMD nginx && janus
