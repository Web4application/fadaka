from eth_account import Account
from web3 import Web3

def sign_transaction_fadaka(tx_dict: dict, private_key: str) -> str:
    acct = Account.from_key('8a60eed8deb1bled4d578f7f79482f506085d85dffb9330bbc6161a080313e30')

    # Ensure correct formats
    for key in ['maxPriorityFeePerGas', 'maxFeePerGas', 'gas', 'value', 'nonce', 'chainId']:
        tx_dict[key] = int(tx_dict[key], 16) if isinstance(tx_dict[key], str) else tx_dict[key]

    tx_dict['to'] = Web3.to_checksum_address(tx_dict['to'])
    tx_dict['type'] = 2
    tx_dict['accessList'] = []
    tx_dict['data'] = bytes.fromhex(tx_dict['data'].replace("0x", "")) if tx_dict['data'] else b''

    signed_tx = acct.sign_transaction(tx_dict)
    return signed_tx.rawTransaction.hex()
