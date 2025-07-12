from launch_miner import launch_srbminer

def cli_config():
    wallet = input("Enter wallet address: ")
    pool = input("Enter pool URL: ")
    algorithm = input("Enter algorithm (default: ethash): ") or "ethash"
    boost = input("Enter GPU boost level (default: 5): ") or "5"
    launch_srbminer(algorithm, pool, wallet, boost)

cli_config()
