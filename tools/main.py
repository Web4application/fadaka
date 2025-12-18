from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from signer import sign_transaction_fadaka
from web3 import Web3
import os

app = FastAPI()

# Configuration
FADAKA_RPC = os.getenv("FADAKA_RPC", "http://localhost:8545")
PRIVATE_KEY = os.getenv("8a60eed8deb1bled4d578f7f79482f506085d85dffb9330bbc6161a080313e30")  # Securely store this!

w3 = Web3(Web3.HTTPProvider(FADAKA_RPC))

class TxData(BaseModel):
    chainId: int
    nonce: int
    maxPriorityFeePerGas: str
    maxFeePerGas: str
    gas: str
    to: str
    value: str
    data: str = ""

@app.post("/sign_fadaka_tx")
def sign_tx(tx: TxData):
    try:
        raw_signed = sign_transaction_fadaka(tx.dict(), PRIVATE_KEY)
        return {"raw_signed_tx": raw_signed}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@app.post("/broadcast_fadaka_tx")
def broadcast_tx(signed_tx: dict):
    try:
        tx_hash = w3.eth.send_raw_transaction(bytes.fromhex(signed_tx['raw_signed_tx'].replace("0x", "")))
        return {"tx_hash": tx_hash.hex()}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
