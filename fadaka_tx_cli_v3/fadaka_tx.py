import sys
import yaml
from web3 import Web3
from eth_account import Account

def load_config():
    with open("fadaka.yaml", "r") as f:
        return yaml.safe_load(f)

def send_tx(raw_tx, rpc_url):
    w3 = Web3(Web3.HTTPProvider(rpc_url))
    tx_hash = w3.eth.send_raw_transaction(bytes.fromhex(raw_tx[2:]))
    print("Transaction sent! TX hash:", tx_hash.hex())

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 fadaka_tx.py <RAW_TX_HEX> [--send]")
        return

    raw_tx = sys.argv[1]
    do_send = "--send" in sys.argv
    config = load_config()

    if do_send:
        send_tx(raw_tx, config["rpc_url"])
    else:
        print("Raw TX:", raw_tx)

if __name__ == "__main__":
    main()