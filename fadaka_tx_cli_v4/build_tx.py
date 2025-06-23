import sys
import argparse
import yaml
import json
from web3 import Web3
from eth_account import Account

def load_config():
    with open("fadaka.yaml", "r") as f:
        return yaml.safe_load(f)

def load_private_key(args):
    if args.keystore and args.password:
        with open(args.keystore, "r") as f:
            encrypted_key = json.load(f)
        return Account.decrypt(encrypted_key, args.password)
    else:
        config = load_config()
        return config["private_key"]

def main():
    parser = argparse.ArgumentParser(description="Fadaka TX Builder")
    parser.add_argument("--to", required=True)
    parser.add_argument("--value", type=float, required=True)
    parser.add_argument("--gas", type=int, default=21000)
    parser.add_argument("--maxFeePerGas", type=int, required=True)
    parser.add_argument("--maxPriorityFeePerGas", type=int, required=True)
    parser.add_argument("--nonce", type=int, required=True)
    parser.add_argument("--chainId", type=int, required=True)
    parser.add_argument("--send", action="store_true")
    parser.add_argument("--keystore", help="Path to keystore file")
    parser.add_argument("--password", help="Password for keystore")

    args = parser.parse_args()
    private_key = load_private_key(args)
    acct = Account.from_key(private_key)
    config = load_config()
    w3 = Web3(Web3.HTTPProvider(config["rpc_url"]))

    tx = {
        "type": 2,
        "nonce": args.nonce,
        "to": Web3.to_checksum_address(args.to),
        "value": Web3.to_wei(args.value, 'ether'),
        "gas": args.gas,
        "maxFeePerGas": Web3.to_wei(args.maxFeePerGas, 'gwei'),
        "maxPriorityFeePerGas": Web3.to_wei(args.maxPriorityFeePerGas, 'gwei'),
        "chainId": args.chainId,
    }

    signed_tx = acct.sign_transaction(tx)
    raw_tx_hex = signed_tx.rawTransaction.hex()

    if args.send:
        tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
        print("Transaction sent! TX hash:", tx_hash.hex())
    else:
        print("Signed raw TX:", raw_tx_hex)

if __name__ == "__main__":
    main()