from eth_account import Account
from web3 import Web3
import rlp
from eth_account._utils.legacy_transactions import serializable_unsigned_transaction_from_dict
from eth_account._utils.typed_transactions import TypedTransaction

# Connect to Fadaka-compatible node (change this!)
w3 = Web3(Web3.HTTPProvider("http://localhost:8545"))

# Raw unsigned transaction (no r, s, v)
raw_tx_hex = "02f87001018462a630118462a63011825208949bf1810999cf0b79beec235308f272567064f9668604d1202b813080c001"
raw_tx_bytes = bytes.fromhex(raw_tx_hex[2:] if raw_tx_hex.startswith("0x") else raw_tx_hex)

# Load private key
private_key = "8a60eed8deb1bled4d578f7f79482f506085d85dffb9330bbc6161a080313e30"  # Replace with your private key
acct = Account.from_key(private_key)

# Parse transaction
typed_tx = TypedTransaction.from_bytes(raw_tx_bytes)
unsigned_tx = typed_tx.inner

# Sign it
signed_tx = Account.sign_transaction(unsigned_tx.as_dict(), private_key)

# Print signed raw transaction
print("📦 Signed TX:", signed_tx.rawTransaction.hex())
print("📨 TX Hash:", signed_tx.hash.hex())

# Optional: Send it
# tx_hash = w3.eth.send_raw_transaction(signed_tx.rawTransaction)
# print("🚀 Sent! Hash:", tx_hash.hex())
