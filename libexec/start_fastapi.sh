#!/bin/bash
echo "⚡️ Starting FastAPI Backend (Tx signing, chat, faucet)..."
uvicorn app.main:app --reload --port 9000
