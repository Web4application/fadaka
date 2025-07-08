from functools import lru_cache
from typing import List, Dict
from web3 import Web3
from .settings import settings

_ERC1155_ABI = [
    # TransferSingle
    { "anonymous": False, "inputs":[
        {"indexed": True,"name":"operator","type":"address"},
        {"indexed": True,"name":"from","type":"address"},
        {"indexed": True,"name":"to","type":"address"},
        {"indexed": False,"name":"id","type":"uint256"},
        {"indexed": False,"name":"value","type":"uint256"}],
      "name":"TransferSingle","type":"event"},
    # TransferBatch
    { "anonymous": False, "inputs":[
        {"indexed": True,"name":"operator","type":"address"},
        {"indexed": True,"name":"from","type":"address"},
        {"indexed": True,"name":"to","type":"address"},
        {"indexed": False,"name":"ids","type":"uint256[]"},
        {"indexed": False,"name":"values","type":"uint256[]"}],
      "name":"TransferBatch","type":"event"},
    # uri()
    { "constant":True,"inputs":[{"name":"id","type":"uint256"}],
      "name":"uri","outputs":[{"name":"","type":"string"}],
      "type":"function" }
]

@lru_cache(maxsize=1)
def w3() -> Web3:
    return Web3(Web3.HTTPProvider(settings.fadaka_rpc))

@lru_cache(maxsize=1)
def contract():
    return w3().eth.contract(address=Web3.to_checksum_address(settings.contract_addr),
                             abi=_ERC1155_ABI)

def fetch_events(start_block: int = 0, end_block="latest") -> List[Dict]:
    """Returns both TransferSingle & TransferBatch as a flat list of dicts."""
    w = w3()
    c = contract()
    logs = []
    # Single
    for ev in c.events.TransferSingle().get_logs(fromBlock=start_block, toBlock=end_block):
        logs.append({
            "tx_hash": ev.transactionHash.hex(),
            "block": ev.blockNumber,
            "ts": w.eth.get_block(ev.blockNumber).timestamp,
            "from": ev.args["from"],
            "to": ev.args["to"],
            "token_id": int(ev.args["id"]),
            "value": int(ev.args["value"]),
        })
    # Batch
    for ev in c.events.TransferBatch().get_logs(fromBlock=start_block, toBlock=end_block):
        for tid, val in zip(ev.args["ids"], ev.args["values"]):
            logs.append({
                "tx_hash": ev.transactionHash.hex(),
                "block": ev.blockNumber,
                "ts": w.eth.get_block(ev.blockNumber).timestamp,
                "from": ev.args["from"],
                "to": ev.args["to"],
                "token_id": int(tid),
                "value": int(val),
            })
    logs.sort(key=lambda x: (x["block"], x["tx_hash"]))
    return logs

def token_uri(token_id: int) -> str:
    """Return the metadata URI (may contain {id} placeholder)."""
    uri_raw: str = contract().functions.uri(token_id).call()
    # EIP‑1155 URIs often have {id} filled with hex‑padded token‑id
    return uri_raw.replace("{id}", format(token_id, "064x"))
