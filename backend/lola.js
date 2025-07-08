const express = require('express');
const { createSessionId } = require('./scripts/tokenGenerator');
const app = express();

app.use(express.json());

app.post('/notify', (req, res) => {
  const { userWallet } = req.body;
  const sessionId = createSessionId();
  console.log(`[Lola] Notifying ${userWallet} → Session: ${sessionId}`);

  // Respond with assistant message
  res.json({
    status: 'success',
    assistantMessage: `Hello! Wallet ${userWallet} connected successfully.`,
    sessionId
  });
});

module.exports = app;
