const axios = require('axios');

async function getCryptoPrice(crypto) {
    const response = await axios.get(`https://api.coingecko.com/api/v3/simple/price?ids=${crypto}&vs_currencies=usd`);
    console.log(`Price of ${crypto}: $${response.data[crypto].usd}`);
}

// Example usage
getCryptoPrice('all');
