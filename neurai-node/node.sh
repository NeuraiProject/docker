#!/usr/bin/env bash

if [[ ! -d /data/node ]]; then
  mkdir -p /data/node
fi

if [[ ! -f /data/node/neurai.conf ]]; then
echo -e "Creating config file..."
mkdir /data > /dev/null 2>&1
mkdir /data/node > /dev/null 2>&1
touch /data/node/neurai.conf
cat <<- EOF > /data/node/neurai.conf
rpcuser=${RPC_USER:-NeuraiDockerUser}
rpcpassword=${RPC_PASS:-NeuraiDockerPassword}
listen=0
daemon=0
server=1
txindex=1
assetindex=1
addressindex=1
timestampindex=1
spentindex=1
pubkeyindex=1
rest=1
dbcache=16
rpcport=${RPC_PORT:-19001}
port=${PORT:-19000}
rpcworkqueue=1024
rpcthreads=16
rpcallowip=0.0.0.0/0
disablewallet=1
rpcbind=0.0.0.0
rpcservertimeout=240
EOF
fi

bash -c "neuraid -datadir=/data/node"
