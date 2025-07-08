const cryptoRandomString = require('crypto-random-string');

// Generate token with fallback support
function generateSecureToken(length = 64, type = 'hex') {
  return cryptoRandomString({ length, type });
}

// For session IDs
function createSessionId() {
  return cryptoRandomString({ length: 32, type: 'base64' });
}

// For notifications or commands
function generateCommandKey(commandName = 'walletCheck') {
  const salt = cryptoRandomString({ length: 6, type: 'numeric' });
  return `${commandName}_${salt}_${Date.now()}`;
}

module.exports = {
  generateSecureToken,
  createSessionId,
  generateCommandKey
};
