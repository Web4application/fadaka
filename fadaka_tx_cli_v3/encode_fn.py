import argparse
import json
from web3 import Web3

def encode_function_call(abi, function_name, args):
    contract = Web3().eth.contract(abi=abi)
    fn = contract.get_function_by_name(function_name)
    return fn(*args).build_transaction()["data"]

def parse_arguments():
    parser = argparse.ArgumentParser(description="Encode ABI function call")
    parser.add_argument("--abi", required=True, help="Path to ABI JSON file")
    parser.add_argument("--function", required=True, help="Function name")
    parser.add_argument("--args", nargs="+", help="Function arguments")
    return parser.parse_args()

def main():
    args = parse_arguments()

    with open(args.abi, "r") as abi_file:
        abi = json.load(abi_file)

    # Try to parse int args where possible
    parsed_args = []
    for arg in args.args or []:
        try:
            parsed_args.append(int(arg))
        except ValueError:
            parsed_args.append(arg)

    encoded_data = encode_function_call(abi, args.function, parsed_args)
    print("Encoded data:", encoded_data)

if __name__ == "__main__":
    main()