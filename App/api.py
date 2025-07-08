from fastapi import FastAPI, Depends, HTTPException, status
from fastapi.security import HTTPBasic, HTTPBasicCredentials
from .settings import settings
from .blockchain import fetch_events, w3, token_uri
from collections import defaultdict
import hashlib, secrets

app = FastAPI(title="Fadaka ERC‑1155 API")
security = HTTPBasic()

def check_auth(creds: HTTPBasicCredentials = Depends(security)):
    user_ok = secrets.compare_digest(creds.username, settings.basic_auth_user)
    pass_ok = secrets.compare_digest(
        hashlib.sha256(creds.password.encode()).hexdigest(),
        hashlib.sha256(settings.basic_auth_pass.encode()).hexdigest())
    if not (user_ok and pass_ok):
        raise HTTPException(status_code=status.HTTP_401_UNAUTHORIZED)
    return creds.username

@app.get("/events", dependencies=[Depends(check_auth)])
def all_events(start_block: int = 0):
    return fetch_events(start_block)

@app.get("/wallet/{address}/1155", dependencies=[Depends(check_auth)])
def wallet_tokens(address: str):
    bal = defaultdict(int)
    for ev in fetch_events(0):
        if ev["from"].lower() == address.lower():
            bal[ev["token_id"]] -= ev["value"]
        if ev["to"].lower() == address.lower():
            bal[ev["token_id"]] += ev["value"]
    # strip zeros
    return {tid: v for tid, v in bal.items() if v > 0}

@app.get("/token/{token_id}/owners", dependencies=[Depends(check_auth)])
def token_owners(token_id: int):
    bal = defaultdict(int)
    for ev in fetch_events(0):
        if ev["token_id"] != token_id: continue
        bal[ev["from"]] -= ev["value"]
        bal[ev["to"]]   += ev["value"]
    return {addr: v for addr, v in bal.items() if v > 0}

@app.get("/token/{token_id}/metadata", dependencies=[Depends(check_auth)])
def token_metadata(token_id: int):
    return {"uri": token_uri(token_id)}
