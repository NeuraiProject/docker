FROM debian:11

LABEL maintainer="Asimov"
LABEL version="1.0.5"
LABEL description="Neurai 1.0.5| Docker for linux x64"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends git curl wget build-essential \
    libtool autotools-dev automake pkg-config bsdmainutils python3 \
    libssl-dev libevent-dev libboost-system-dev libboost-filesystem-dev \
    libboost-chrono-dev libboost-test-dev libboost-thread-dev \
    libminiupnpc-dev libzmq3-dev ca-certificates bison && \
    git clone --depth 1 --single-branch --branch 1.0.5 https://github.com/NeuraiProject/Neurai.git /build && \
    cd /build/depends && \
    make HOST=x86_64-pc-linux-gnu -j$(nproc) && \
    cd /build && \
    ./autogen.sh && \
    contrib/install_db4.sh /tmp && \
    export BDB_PREFIX=/tmp/db4 && \
    CONFIG_SITE=$PWD/depends/x86_64-pc-linux-gnu/share/config.site ./configure \
    --prefix=/usr/local \
    --enable-cxx --disable-shared --disable-tests --disable-gui --disable-gui-tests --with-pic \
    LDFLAGS="-L${BDB_PREFIX}/lib/" CPPFLAGS="-I${BDB_PREFIX}/include/" && \
    make -j$(nproc) && \
    make install && \
    strip /usr/local/bin/neuraid /usr/local/bin/neurai-cli && \
    cd / && \
    rm -rf /build /tmp/db4 /var/lib/apt/lists/* /root/.cache /tmp/* && \
    apt-get purge -y git curl wget build-essential libtool autotools-dev automake \
    pkg-config bsdmainutils python3 libssl-dev libevent-dev libboost-system-dev \
    libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev \
    libminiupnpc-dev libzmq3-dev bison && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY node.sh /node.sh

RUN chmod +x /node.sh && mkdir -p /data

VOLUME /data

EXPOSE 19000 19001

ENTRYPOINT ["/node.sh"]
