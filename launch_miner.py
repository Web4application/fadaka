import subprocess

def launch_srbminer(algorithm="ethash", pool="us-south01.miningrigrentals.com:3344", wallet="your_wallet_address", password="x"):
    command = [
        "./SRBMiner-MULTI",
        "--algorithm", algorithm,
        "--pool", pool,
        "--wallet", wallet,
        "--password", password
    ]
    
    print("Launching miner with:")
    print(" ".join(command))

    try:
        subprocess.run(command, check=True)
    except FileNotFoundError:
        print("⚠️ SRBMiner-MULTI executable not found. Make sure it's in your working directory.")
    except subprocess.CalledProcessError:
        print("🚨 Miner exited with an error.")

# Example usage
launch_srbminer(wallet="web4.331855")
