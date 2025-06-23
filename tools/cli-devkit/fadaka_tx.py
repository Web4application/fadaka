import sys
import yaml
import json
import argparse
from web3 import Web3
from eth_account import Account

def load_config():
    with open("fadaka.yaml", "r") as f:
        return yaml.safe_load(f)

def load_private_key(keystore_path, password):
    with open(keystore_path, "r") as f:
        encrypted = json.load(f)
    return Account.decrypt(encrypted, password)

def main():
    parser = argparse.ArgumentParser(description="Fadaka TX Sender")
    parser.add_argument("raw_tx", help="Raw transaction hex")
    parser.add_argument("--send", action="store_true")
    parser.add_argument("--keystore", help="Path to keystore")
    parser.add_argument("--password", help="Password for keystore")

    args = parser.parse_args()
    config = load_config()
    w3 = Web3(Web3.HTTPProvider(config["rpc_url"]))

    if args.send:
        tx_hash = w3.eth.send_raw_transaction(bytes.fromhex(args.raw_tx[2:]))
        print("Transaction sent! TX hash:", tx_hash.hex())
    else:
        print("Raw TX:", args.raw_tx)

if __name__ == "__main__":
    main()