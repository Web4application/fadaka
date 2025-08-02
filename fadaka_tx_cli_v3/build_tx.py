import sys
import argparse
import yaml
from web3 import Web3
from eth_account import Account

def load_config():
    with open("fadaka.yaml", "r") as f:
        return yaml.safe_load(f)

def main():
    parser = argparse.ArgumentParser(description="Fadaka TX Builder")
    parser.add_argument("--to", required=True, help="Recipient address")
    parser.add_argument("--value", type=float, required=True, help="ETH value in Ether")
    parser.add_argument("--gas", type=int, default=21000, help="Gas limit")
    parser.add_argument("--maxFeePerGas", type=int, required=True, help="Max fee per gas (in gwei)")
    parser.add_argument("--maxPriorityFeePerGas", type=int, required=True, help="Priority fee per gas (in gwei)")
    parser.add_argument("--nonce", type=int, required=True, help="Transaction nonce")
    parser.add_argument("--chainId", type=int, required=True, help="Chain ID")
    parser.add_argument("--send", action="store_true", help="Send transaction via RPC")

    args = parser.parse_args()
    config = load_config()
    w3 = Web3(Web3.HTTPProvider(config["rpc_url"]))
    private_key = config["private_key"]
    acct = Account.from_key(private_key)

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