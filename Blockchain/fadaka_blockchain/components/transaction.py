from pydantic import BaseModel
import time

class Transaction(BaseModel):
    sender: str
    recipient: str
    amount: float
    timestamp: float = time.time()
