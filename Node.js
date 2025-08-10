from .blockchain import Blockchain

def run():
    bc = Blockchain()
    bc.add_block("Fadaka test block 1")
    bc.add_block("Fadaka test block 2")

    for block in bc.chain:
        print(f"Block {block.index}: {block.hash} [nonce: {block.nonce}]")

    print("Is chain valid?", bc.is_valid())

if __name__ == "__main__":
    run()
