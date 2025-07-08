# viewer_fadaka.py
import os, time, streamlit as st, pandas as pd
from web3 import Web3

RPC_URL = os.getenv("FADAKA_RPC", "http://localhost:8545")
CONTRACT_ADDR = Web3.to_checksum_address("0xb99925ea17c3780e8b96b4254b911364434be7cc")

# 1. Web3 connection
w3 = Web3(Web3.HTTPProvider(RPC_URL))
assert w3.is_connected(), "Cannot reach Fadaka RPC"

# 2. Minimal ABI with just TransferSingle / Batch
ABI = [
    {
        "anonymous": False,
        "inputs": [
            {"indexed": True,  "name": "operator", "type": "address"},
            {"indexed": True,  "name": "from",     "type": "address"},
            {"indexed": True,  "name": "to",       "type": "address"},
            {"indexed": False, "name": "id",       "type": "uint256"},
            {"indexed": False, "name": "value",    "type": "uint256"}
        ],
        "name": "TransferSingle",
        "type": "event"
    },
    {
        "anonymous": False,
        "inputs": [
            {"indexed": True,  "name": "operator", "type": "address"},
            {"indexed": True,  "name": "from",     "type": "address"},
            {"indexed": True,  "name": "to",       "type": "address"},
            {"indexed": False, "name": "ids",      "type": "uint256[]"},
            {"indexed": False, "name": "values",   "type": "uint256[]"}
        ],
        "name": "TransferBatch",
        "type": "event"
    },
]

contract = w3.eth.contract(address=CONTRACT_ADDR, abi=ABI)

@st.cache_data(ttl=60)  # refresh every minute
def fetch_events(start_block=0, end_block="latest"):
    events = []
    for ev in contract.events.TransferSingle().get_logs(
        fromBlock=start_block, toBlock=end_block
    ):
        events.append({
            "tx_hash": ev.transactionHash.hex(),
            "block_number": ev.blockNumber,
            "timestamp": w3.eth.get_block(ev.blockNumber).timestamp,
            "from": ev.args["from"],
            "to": ev.args["to"],
            "token_id": ev.args["id"],
            "value": ev.args["value"],
        })
    # Optional: parse TransferBatch similarly
    return pd.DataFrame(events)

st.title("Fadaka ERC‑1155 Live Dashboard")

start_block = st.number_input("Fetch from block", value=0, step=1)
df = fetch_events(start_block)

# Convert timestamp for readability
if not df.empty:
    df["datetime"] = pd.to_datetime(df["timestamp"], unit="s")

wallet_filter = st.text_input("Filter by wallet address").lower()
token_filter  = st.text_input("Filter by token ID")

if wallet_filter:
    df = df[(df["from"].str.lower() == wallet_filter) |
            (df["to"].str.lower() == wallet_filter)]

if token_filter:
    df = df[df["token_id"].astype(str) == token_filter]

st.write(f"Total rows: {len(df)}")
st.dataframe(df)

