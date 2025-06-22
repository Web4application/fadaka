# Example of zk-SNARKs using the pycryptodome library

from Crypto.PublicKey import RSA

def generate_keys():
    key = RSA.generate(2048)
    private_key = key.export_key()
    public_key = key.publickey().export_key()
    return private_key, public_key

# Generate keys
private_key, public_key = generate_keys()
print("Private Key:", private_key.decode())
print("Public Key:", public_key.decode())
