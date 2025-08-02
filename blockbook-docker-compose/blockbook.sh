#!/usr/bin/env bash
set -e

# Var
: "${BLOCKBOOK_PUBLIC_PORT:=9168}"
: "${BLOCKBOOK_INTERNAL_PORT:=9068}"
: "${BACKEND_DATADIR:=/data/backend}"
: "${BLOCKBOOK_DATADIR:=/data/blockbook}"
: "${NEURAI_CONF:=/opt/coins/nodes/neurai/neurai.conf}"

mkdir -p "${BACKEND_DATADIR}" "${BLOCKBOOK_DATADIR}/logs"

echo "[INFO] Starting neurai daemon..."
/opt/coins/nodes/neurai/neuraid -datadir="${BACKEND_DATADIR}" -conf="${NEURAI_CONF}" -pid=/run/neurai.pid & NEURAI_PID=$!

cd /opt/coins/blockbook/neurai/

# Waiting for neurai daemon to be ready
sleep 10

echo "[INFO] Starting blockbook..."
exec /opt/coins/blockbook/neurai/bin/blockbook \
  -blockchaincfg=/opt/coins/blockbook/neurai/config/blockchaincfg.json \
  -datadir="${BLOCKBOOK_DATADIR}" \
  -sync \
  -internal=":${BLOCKBOOK_INTERNAL_PORT}" \
  -public=":${BLOCKBOOK_PUBLIC_PORT}" \
  -certfile=/opt/coins/blockbook/neurai/cert/blockbook \
  -explorer= \
  -log_dir="${BLOCKBOOK_DATADIR}/logs"
