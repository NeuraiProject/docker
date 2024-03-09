# Build with: `docker build -t rpc-neurai .`

FROM ubuntu:22.04

LABEL maintainer="Neurai"

LABEL version="1.0.0"

LABEL description="Docker for neurai node + rpc-neurai"

ARG DEBIAN_FRONTEND=nointeractive

WORKDIR /root

RUN apt update 

RUN apt install curl -y 

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - 
    
RUN apt update

ENV PACKAGES="\
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
  nodejs \
  libssl-dev \
  libboost-chrono-dev \
  libboost-filesystem-dev \
  libboost-program-options-dev \
  libboost-system-dev \
  libboost-thread-dev \
  libboost-test-dev \
  libevent-dev \
  libprotobuf-dev \
  zlib1g-dev \
  libczmq-dev \
  protobuf-compiler \
  "
RUN apt update && apt install --no-install-recommends -y $PACKAGES  && \
    rm -rf /var/lib/apt/lists/* && \
    apt clean

# NEURAI NODE

WORKDIR /data/src

RUN git clone https://github.com/NeuraiProject/Neurai


WORKDIR /data/src/Neurai

RUN contrib/install_db4.sh ..

RUN ./autogen.sh 

RUN ./configure --disable-tests --disable-bench BDB_LIBS="-L/data/src/db4/lib -ldb_cxx-4.8" BDB_CFLAGS="-I/data/src/db4/include" --with-gui=no

RUN make -j4

RUN make install

# RPC-NEURAI

WORKDIR /data

RUN git clone https://github.com/NeuraiProject/neurai-rpc-proxy neurai-rpc-proxy

WORKDIR /data/neurai-rpc-proxy

RUN npm install

VOLUME /root

# COPY SCRIPT TO CONTAINER

COPY run.sh /run.sh

RUN chmod 755 /run.sh

EXPOSE 80

ENTRYPOINT ["/bin/sh", "-c" , "/run.sh"]