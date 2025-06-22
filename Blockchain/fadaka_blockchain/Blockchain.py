from .block import Block
import time

class Blockchain:
    def __init__(self):
        self.chain = [self.create_genesis_block()]
        self.difficulty = 3

    def create_genesis_block(self):
        return Block(0, time.time(), "Genesis Block", "0")

    def get_last_block(self):
        return self.chain[-1]

    def proof_of_work(self, block):
        block.nonce = 0
        while not block.hash.startswith("0" * self.difficulty):
            block.nonce += 1
            block.hash = block.calculate_hash()
        return block

    def add_block(self, data):
        previous_block = self.get_last_block()
        new_block = Block(len(self.chain), time.time(), data, previous_block.hash)
        mined_block = self.proof_of_work(new_block)
        self.chain.append(mined_block)

    def is_valid(self):
        for i in range(1, len(self.chain)):
            current = self.chain[i]
            previous = self.chain[i - 1]

            if current.hash != current.calculate_hash():
                return False
            if current.previous_hash != previous.hash:
                return False
        return True
