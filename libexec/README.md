# Fadaka libexec Tools

A set of scripts to streamline local development of the Fadaka blockchain system.

## Scripts

- `run_fadaka_node.sh` — Start the Go blockchain node
- `deploy_contracts.sh` — Deploy FDAK, Router, Faucet using Hardhat
- `start_fastapi.sh` — Start tx signing + faucet API
- `test_api_endpoints.sh` — Quick curl tests for API
- `launch_dashboard.sh` — Start Swift Beta wallet UI
- `faucet_test.sh` — Test minting via faucet

All scripts assume you have `go`, `node`, `uvicorn`, `curl`, and `jekyll` installed.
