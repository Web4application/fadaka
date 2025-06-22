peer_nodes = set()

def register_node(address: str):
    peer_nodes.add(address)

def get_nodes():
    return list(peer_nodes)
