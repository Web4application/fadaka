const p2pNetworking = require('./p2pNetworking');

// Simple server setup for P2P network
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('Fadaka Blockchain P2P Network');
});

app.listen(port, () => {
  console.log(`Fadaka P2P Server running at http://localhost:${port}`);
});
