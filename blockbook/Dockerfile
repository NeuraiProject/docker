FROM ubuntu:22.04

LABEL maintainer="Asimov"
LABEL version="1.0.2"
LABEL description="Neurai Docker"

ARG DEBIAN_FRONTEND=nointeractive
RUN apt update
RUN apt-get install -y curl

COPY ./blockbook.sh /
RUN chmod 755 /blockbook.sh

WORKDIR /root

RUN curl -LJO https://github.com/NeuraiProject/blockbook/releases/download/4.0.0.1/backend-neurai_1.0.2.0-neurai-dev_amd64.deb 
RUN curl -LJO https://github.com/NeuraiProject/blockbook/releases/download/4.0.0.1/blockbook-neurai_0.4.0_amd64.deb

RUN apt install -y ./backend-neurai_1.0.2.0-neurai-dev_amd64.deb 
RUN apt install -y ./blockbook-neurai_0.4.0_amd64.deb 

WORKDIR /data
VOLUME /data

EXPOSE 9168 8168

#CMD tail -f /dev/null

ENTRYPOINT ["/bin/sh", "-c" , "/blockbook.sh"]