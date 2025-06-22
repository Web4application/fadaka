import hashlib
import secrets

class Wallet:
    def __init__(self):
        self.private_key = secrets.token_hex(32)
        self.public_key = self.generate_public_key()

    def generate_public_key(self):
        return hashlib.sha256(self.private_key.encode()).hexdigest()

    def get_address(self):
        return self.public_key[-40:]  # pseudo address
