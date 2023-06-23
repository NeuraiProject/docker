#!/usr/bin/env bash

if [[ ! -d /data/node ]]; then
  mkdir -p /data/node
fi

cp /root/neurai.conf /data/node/neurai.conf

bash -c "neuraid -datadir=/data/node"