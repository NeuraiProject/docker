FROM debian:bookworm

LABEL maintainer="Satolight"

ARG DEBIAN_FRONTEND=noninteractive
ARG BACKEND_VERSION=backend-neurai-hw_1.0.4.0-neurai-dev_amd64
ARG BLOCKBOOK_VERSION=blockbook-neurai-hw_0.4.0_amd64

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

COPY ./blockbook.sh /blockbook.sh
RUN chmod 755 /blockbook.sh

WORKDIR /root

RUN curl -LJO https://github.com/NeuraiProject/blockbook/releases/download/4.0.0.1/${BACKEND_VERSION}.deb && \
    curl -LJO https://github.com/NeuraiProject/blockbook/releases/download/4.0.0.1/${BLOCKBOOK_VERSION}.deb && \
    apt-get update && \
    apt-get install -y ./${BACKEND_VERSION}.deb ./${BLOCKBOOK_VERSION}.deb && \
    rm ${BACKEND_VERSION}.deb ${BLOCKBOOK_VERSION}.deb

VOLUME /data

EXPOSE 9168

ENTRYPOINT ["/blockbook.sh"]
