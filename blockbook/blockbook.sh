#!/usr/bin/env bash

if [[ ! -d /data/backend ]]; then
  mkdir -p /data/backend
fi

if [[ ! -d /data/blockbook ]]; then
  mkdir -p /data/blockbook
fi

bash -c "/opt/coins/nodes/neurai/neuraid -datadir=/data/backend -conf=/opt/coins/nodes/neurai/neurai.conf -pid=/run/neurai/neurai.pid"

cd /opt/coins/blockbook/neurai/

bash -c "/opt/coins/blockbook/neurai/bin/blockbook -blockchaincfg=/opt/coins/blockbook/neurai/config/blockchaincfg.json -datadir=/data/blockbook -sync -internal=:9068 -public=:9168 -certfile=/opt/coins/blockbook/neurai/cert/blockbook -explorer= -log_dir=/data/blockbook/logs"
