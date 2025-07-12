import axios from 'axios';

async function getBinanceMarketData() {
  try {
    const response = await axios.get('https://api.binance.com/api/v3/ticker/price');
    console.log(response.data);
  } catch (error) {
    console.error('Error fetching market data:', error);
  }
}

export default getBinanceMarketData;
