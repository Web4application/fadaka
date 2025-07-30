# File: api/rebalancer.py

from fastapi import APIRouter, HTTPException
from pydantic import BaseModel

router = APIRouter()

class RebalanceRequest(BaseModel):
    vault_id: str
    strategy: str
    agent_signature: str  # Signed by AI agent's wallet

@router.post("/rebalance")
def trigger_rebalance(req: RebalanceRequest):
    # Verify agent signature (pseudo-code)
    if not verify_signature(req.agent_signature, expected_agent_address):
        raise HTTPException(status_code=403, detail="Unauthorized AI agent")

    # Trigger vault rebalancing
    success = execute_vault_strategy(req.vault_id, req.strategy)
    if success:
        return {"status": "ok", "strategy_applied": req.strategy}
    else:
        raise HTTPException(status_code=500, detail="Rebalance failed")
