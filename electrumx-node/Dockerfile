# Build with: `docker build -t electrumx-neurai .`

FROM ubuntu:20.04

LABEL maintainer="Neurai"
LABEL version="1.0.0"
LABEL description="Docker for neurai node 1.2 + electrumx"

ARG DEBIAN_FRONTEND=nointeractive

RUN apt update

ENV PACKAGES="\
  curl \
  bsdmainutils \
  build-essential \
  libcurl4-openssl-dev \
  software-properties-common \
  ubuntu-drivers-common \
  pkg-config \
  libtool \
  openssh-server \
  unzip \
  git \
  clinfo \
  autoconf \
  automake \
  libleveldb-dev \
  gcc \
  wget \
  cmake \
  python3 \
  python3-dev \
  python3-pip \
  build-essential libssl-dev libboost-chrono-dev \
  libboost-filesystem-dev libboost-program-options-dev \
  libboost-system-dev libboost-thread-dev libboost-test-dev \
  qtbase5-dev qttools5-dev bison libexpat1-dev libdbus-1-dev libfontconfig-dev \
  libfreetype6-dev libice-dev libsm-dev libx11-dev libxau-dev libxext-dev \
  libevent-dev libxcb1-dev libxkbcommon-dev libminiupnpc-dev libprotobuf-dev \
  libqrencode-dev xcb-proto x11proto-xext-dev x11proto-dev xtrans-dev zlib1g-dev \
  libczmq-dev autoconf automake libtool protobuf-compiler \
  "
RUN apt update && apt install --no-install-recommends -y $PACKAGES  && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

RUN mkdir /data/
RUN mkdir /data/src
WORKDIR /data/src

RUN git clone https://github.com/NeuraiProject/Neurai


WORKDIR /data/src/Neurai
RUN contrib/install_db4.sh ..
RUN ./autogen.sh 
RUN ./configure --disable-tests --disable-bench BDB_LIBS="-L/data/src/db4/lib -ldb_cxx-4.8" BDB_CFLAGS="-I/data/src/db4/include" --with-gui=no
RUN make -j4
RUN make install

# ELECTRUMX

WORKDIR /data

RUN git clone https://github.com/NeuraiProject/electrumx-neurai.git electrumx

WORKDIR /data/electrumx

RUN python3 -m pip install -r requirements.txt

# ELECTRUMX ENV

ENV DAEMON_URL=http://${RPC_USER:-NeuraiDockerUser}:${RPC_PASS:-NeuraiDockerPassword}@localhost:19001/
ENV COIN=Neurai
ENV REQUEST_TIMEOUT=120
ENV DB_DIRECTORY=/root/electrumdb
ENV DB_ENGINE=leveldb
ENV SERVICES=tcp://0.0.0.0:19011,SSL://0.0.0.0:19012,rpc://:8000
ENV SSL_CERTFILE=/root/electrumdb/server.crt
ENV SSL_KEYFILE=/root/electrumdb/server.key
ENV HOST=""
ENV ALLOW_ROOT=true
ENV CACHE_MB=10000
ENV MAX_SESSIONS=10000
ENV MAX_SEND=10000000
ENV MAX_RECV=10000000
ENV EVENT_LOOP_POLICY=uvloop

VOLUME /root

COPY run.sh /run.sh
RUN chmod 755 /run.sh

EXPOSE 19000 19011 19012 8000

ENTRYPOINT ["/bin/sh", "-c" , "/run.sh"]

