from flask import Flask, request, jsonify
import secrets
import time

app = Flask(__name__)

def generate_event_id(event_type="TX"):
    salt = secrets.token_hex(4)
    return f"{event_type}_{salt}_{int(time.time())}"

@app.route('/log', methods=['POST'])
def log_event():
    data = request.json
    event_type = data.get("type", "TX")
    event_id = generate_event_id(event_type)
    payload = data.get("payload", {})

    print(f"[RODAAI] Logged: {event_id}")
    return jsonify({
        "event_id": event_id,
        "status": "logged",
        "timestamp": time.time(),
        "payload": payload
    })

if __name__ == "__main__":
    app.run(port=5000)
