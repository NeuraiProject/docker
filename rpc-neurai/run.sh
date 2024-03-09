#!/usr/bin/env bash

if [[ ! -f /root/.neurai/neurai.conf ]]; then
echo -e "Creating config file..."
mkdir /root/.neurai > /dev/null 2>&1
touch /root/.neurai/neurai.conf
cat <<- EOF > /root/.neurai/neurai.conf
rpcuser=${RPC_USER:-NeuraiDockerUser}
rpcpassword=${RPC_PASS:-NeuraiDockerPassword}
listen=1
daemon=1
server=1
rest=1
dbcache=5
rpcworkqueue=1024
rpcthreads=128
rpcallowip=0.0.0.0/0
disablewallet=1
rpcbind=0.0.0.0
txindex=1
assetindex=1
addressindex=1
timestampindex=1
spentindex=1
rpcservertimeout=240
EOF
fi

rm /data/neurai-rpc-proxy/config.json 2>&1

if [[ ! -f /data/neurai-rpc-proxy/config.json ]]; then
touch /data/neurai-rpc-proxy/config.json

cat <<- EOF > /data/neurai-rpc-proxy/config.json
    {
        "concurrency": 4,
        "endpoint": "https://xna-rpc.host.org/rpc",
        "environment": "Neurai",
        "local_port": 80,
        "nodes": [
          {
            "name": "Node 1",
            "username": "${RPC_USER:-NeuraiDockerUser}",
            "password": "${RPC_PASS:-NeuraiDockerPassword}",
            "neurai_url": "http://localhost:19001"
          }
        ]
      }
EOF
fi

echo -e "Starting daemon and rpc-neurai"
bash -c "neuraid && cd /data/neurai-rpc-proxy/ && npm start"