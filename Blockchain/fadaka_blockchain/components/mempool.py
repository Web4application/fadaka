mempool = []

def add_transaction(tx):
    mempool.append(tx)

def get_pending_transactions():
    return mempool

def clear_mempool():
    mempool.clear()
