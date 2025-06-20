const io = require('socket.io')(3001);
const peers = [];  // Array to store connected peers

// When a peer connects
io.on('connection', (socket) => {
  console.log('New peer connected:', socket.id);

  // Add the new peer to the list
  peers.push(socket);

  // Broadcast to all peers
  socket.emit('message', { text: 'Hello from the new peer!' });

  // Handle incoming messages
  socket.on('message', (data) => {
    console.log('Received message:', data);
  });

  // When a peer disconnects
  socket.on('disconnect', () => {
    console.log('Peer disconnected:', socket.id);
    const index = peers.indexOf(socket);
    if (index !== -1) peers.splice(index, 1);
  });
});

// Function to broadcast messages to all peers
function broadcast(message) {
  peers.forEach((peer) => {
    peer.emit('message', message);
  });
}

// Export for external usage
module.exports = { broadcast };
