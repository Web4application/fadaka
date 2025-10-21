#!/bin/bash

# Step 1: Compile the circuit
circom circuits/transfer.circom --wasm --r1cs --sym

# Step 2: Trusted setup
snarkjs groth16 setup circuits/transfer.r1cs pot12_final.ptau circuits/transfer_0000.zkey
snarkjs zkey contribute circuits/transfer_0000.zkey circuits/transfer_final.zkey --name="Fadaka Setup"

# Step 3: Export verifier contract
snarkjs zkey export verificationkey circuits/transfer_final.zkey circuits/verification_key.json
snarkjs generateverifier circuits/transfer_final.zkey verifier/FadakaVerifier.sol

echo "Setup complete! Run 'python scripts/generate_proof.py' to generate zk-SNARK proofs."

npm install -g circom snarkjs
pip install json

cd scripts
python generate_proof.py
