
# Blockbook Docker‑Compose

This directory contains a Docker Compose configuration to deploy **Blockbook**, a block explorer with REST API endpoints, tailored for the Neurai blockchain.

---

## 🚀 Purpose & Scope

Run a self‑hosted Blockbook instance integrated with Neurai blockchain nodes via Docker Compose. The service exposes API endpoints to query addresses, balances, and transaction history.

---

## Architecture Overview

* **Blockbook service**: Containerized block explorer exposing HTTP API.
* **Data volume**: Persisted indices and chain data.
* **Networking**: Interconnected with Neurai node(s) exposing RPC JSON‑RPC ports.

---

## Prerequisites

* Docker Engine ≥ 20.x
* Docker Compose (v1.29+ or v2)
* Access to a Neurai full node with RPC endpoint
* Sufficient disk space (> 20 GB) for blockchain indices

---

## Quickstart

1. Clone this repository:

   ```bash
   git clone https://github.com/NeuraiProject/docker.git
   cd docker/blockbook-docker-compose
   ```

2. Update `docker-compose.yml`:

   * Set `DATA_DIR` for persistence.
   * Configure environment variables:

     ```yaml
     services:
       blockbook:
         image: blockbook:latest
         environment:
           - NEURAI_RPC_URL=http://<node-host>:<rpc-port>
           - NETWORK=Neurai
           - RPC_USER=<user>        # if RPC authentication is enabled
           - RPC_PASSWORD=<pass>
     ```

3. Launch stack:

   ```bash
   docker-compose up -d
   ```

4. The Blockbook API is available at:

   ```
   http://<host>:<exposed_port>/api/v4
   ```

---

## Configuration Parameters

| Variable         | Description                           | Default / Example  |
| ---------------- | ------------------------------------- | ------------------ |
| `NEURAI_RPC_URL` | URL to Neurai node JSON‑RPC interface | `http://node:port` |
| `NETWORK`        | Blockchain network identifier         | `Neurai`           |
| `RPC_USER`       | For RPC auth (if enabled)             | —                  |
| `RPC_PASSWORD`   | For RPC auth (if enabled)             | —                  |
| `DATA_DIR`       | Path for persistent Blockbook data    | `./data`           |

---

## Usage Examples

* Get balance by address:

  ```
  GET /api/v4/address/:address
  ```

* Retrieve transaction history:

  ```
  GET /api/v4/address/:address/txs
  ```

* Explore a block:

  ```
  GET /api/v4/block/:hashOrHeight
  ```

---

## Maintenance & Upgrades

* To rebuild after updating:

  ```bash
  docker-compose pull
  docker-compose up -d
  ```

* Monitor logs:

  ```bash
  docker-compose logs -f blockbook
  ```

* To erase data and reindex:

  ```bash
  docker-compose down
  rm -rf data/blockbook-index
  docker-compose up -d
  ```

---

## Troubleshooting

* **Blockbook cannot connect to RPC**: Verify `NEURAI_RPC_URL`, credentials, and that network policy allows connectivity.
* **Slow indexing**: Ensure that Neurai node is fully synced and indexed.
* **Persistent failures**: Inspect log output for stack traces or RPC errors; restart if needed.

---

## Contribution & Support

This setup is a part of \[NeuraiProject/docker] repository. Contributions to improve configuration, security, or deployment support are welcome via pull requests.

For broader help with Neurai network or tooling, refer to the Neurai documentation and community forums.

---

### References

* Blockbook Docker build documentation: dependencies primarily Docker Engine, minimal external requirements ([github.com][1], [github.com][2])
* NeuraiProject Docker overview listing Blockbook as a block explorer service ([github.com][1], [github.com][1])

---

⚙️ If you’d like extended sections (e.g. integration testing, load‑balancing configurations, network-specific tuning), just let me know!

[1]: https://github.com/NeuraiProject/docker?utm_source=chatgpt.com "NeuraiProject/docker - GitHub"
[2]: https://github.com/trezor/blockbook/blob/master/docs/build.md?utm_source=chatgpt.com "blockbook/docs/build.md at master - GitHub"
