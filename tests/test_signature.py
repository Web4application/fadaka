import fadaka_rs

def test_block_hash():
    msg = "hello"
    hash_val = fadaka_rs.block_hash(msg)
    assert len(hash_val) == 64
    print("✅ Hash test passed:", hash_val)
