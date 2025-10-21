import subprocess
import json

def generate_zk_proof(sender_balance: int, transfer_amount: int):
    # Step 1: Create input.json for circom
    input_data = {"senderBalance": sender_balance, "transferAmount": transfer_amount}
    with open("input.json", "w") as f:
        json.dump(input_data, f)

    # Step 2: Generate proof using snarkjs
    subprocess.run(["snarkjs", "groth16", "fullprove", "input.json", "transfer.wasm", "transfer_final.zkey", "proof.json", "public.json"])

    # Step 3: Load proof
    with open("proof.json") as f:
        proof = json.load(f)
    with open("public.json") as f:
        public_signals = json.load(f)

    return proof, public_signals

if __name__ == "__main__":
    proof, public_signals = generate_zk_proof(1000, 150)
    print("Proof:", proof)
    print("Public Signals:", public_signals)
