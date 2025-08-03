
# Neurai Docker Services

A collection of Docker images and Docker Compose configurations to run the key components of the Neurai ecosystem.

---

## Prerequisites

- [Docker Engine](https://docs.docker.com/engine/) ≥ 20.10  
- [Docker Compose](https://docs.docker.com/compose/) ≥ 1.29  
- (Optional) API keys or credentials as required by individual services  

---

## Repository Structure

```text
.
├── blockbook-docker-compose/   # Docker Compose for Blockbook + dependencies
├── blockbook/                  # Standalone Blockbook Dockerfile
├── electrumx-node/             # Dockerfile for ElectrumX + integrated Neurai node
├── neurai-node/                # Dockerfile for standalone Neurai node
└── rpc-neurai/                 # Dockerfile for Neurai node + RPC API service
````

Each directory contains a `Dockerfile` (and, where appropriate, a `docker-compose.yml`) plus a sample `.env.example` for environment-variable configuration.

---

## License

No license is specified in this repository. If you wish to apply an open-source license, add a `LICENSE` file (e.g., [MIT](https://opensource.org/licenses/MIT)).


