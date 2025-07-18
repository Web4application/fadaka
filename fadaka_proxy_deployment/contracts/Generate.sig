import hashlib

# Provided unknown selectors (hex, 4 bytes)
unknown_selectors = [
    "f578063e",
    "461072a5",
    "9010d07c",
    "91d14854",
    "95d89b41",
    “23b872dd”,
   “2f2ff15d”,
   “313ce567”,
   “3408e470”,
  “36568abe”,
 “248a9ca3”,
 “2d0335ab”,
 “06fdde03”,
 “095ea7b3”,
 “70a08231”,
 “a9059cbb”,
 “18160ddd”,
 “91d14854”,
 “95d89b41”,
]

def keccak256(data: bytes) -> bytes:
    import sha3
    k = sha3.keccak_256()
    k.update(data)
    return k.digest()

def get_selector(signature: str) -> str:
    hash_bytes = keccak256(signature.encode())
    return hash_bytes[:4].hex()

matches = {}

for func in common_functions:
    selector = get_selector(func)
    if selector in unknown_selectors:
        matches[selector] = func

print("Matches found:")
for sel, sig in matches.items():
    print(f"{sel} -> {sig}")
