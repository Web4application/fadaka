from flask import Flask, request, jsonify

app = Flask(__name__)
blockchain = []

@app.route('/broadcast_block', methods=['POST'])
def receive_block():
    data = request.get_json()
    blockchain.append(data)
    return jsonify({"status": "Block received"}), 200

@app.route('/chain', methods=['GET'])
def get_chain():
    return jsonify(blockchain), 200

app.run(host='0.0.0.0', port=5000)

# registry_server.py
from flask import Flask, request, jsonify
app = Flask(__name__)
peer_list = []

@app.route('/register', methods=['POST'])
def register():
    peer = request.get_json()['address']
    if peer not in peer_list:
        peer_list.append(peer)
    return jsonify({"peers": peer_list}), 200

@app.route('/peers', methods=['GET'])
def get_peers():
    return jsonify(peer_list), 200

app.run(port=6000)
