import os
import json
from Crypto.Cipher import AES
from Crypto.Protocol.KDF import scrypt
from Crypto.Random import get_random_bytes
from base64 import b64encode, b64decode

KEY_LENGTH = 32
SALT_LENGTH = 16
NONCE_LENGTH = 12

def generate_salt() -> bytes:
    """Generate a secure random salt."""
    return get_random_bytes(SALT_LENGTH)

def derive_key(password: str, salt: bytes) -> bytes:
    """Derive a key using Scrypt."""
    return scrypt(password.encode(), salt, KEY_LENGTH, N=2**14, r=8, p=1)

def encrypt_private_key(private_key: str, password: str) -> str:
    """Encrypt a private key using AES-GCM."""
    salt = generate_salt()
    key = derive_key(password, salt)
    cipher = AES.new(key, AES.MODE_GCM)
    ciphertext, tag = cipher.encrypt_and_digest(private_key.encode())
    encrypted_data = {
        "salt": b64encode(salt).decode(),
        "nonce": b64encode(cipher.nonce).decode(),
        "ciphertext": b64encode(ciphertext).decode(),
        "tag": b64encode(tag).decode()
    }
    return json.dumps(encrypted_data)

def decrypt_private_key(encrypted_data: str, password: str) -> str:
    """Decrypt a private key using AES-GCM."""
    data = json.loads(encrypted_data)
    salt = b64decode(data["salt"])
    nonce = b64decode(data["nonce"])
    ciphertext = b64decode(data["ciphertext"])
    tag = b64decode(data["tag"])

    key = derive_key(password, salt)
    cipher = AES.new(key, AES.MODE_GCM, nonce=nonce)

    try:
        decrypted_data = cipher.decrypt_and_verify(ciphertext, tag)
        return decrypted_data.decode()
    except ValueError:
        raise Exception("Decryption failed. Invalid password or corrupted data.")
