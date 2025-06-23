import React, { useState } from 'react';
import connectTrustWallet from './trustwallet';

function TrustWalletIntegration() {
  const [account, setAccount] = useState('');

  const handleConnectTrustWallet = async () => {
    await connectTrustWallet();
    // Assuming the account is set in the connectTrustWallet function
    const accounts = await web3.eth.getAccounts();
    setAccount(accounts[0]);
  };

  return (
    <div>
      <h1>Trust Wallet Integration</h1>
      <button onClick={handleConnectTrustWallet}>Connect Trust Wallet</button>
      <p>Connected Account: {account}</p>
    </div>
  );
}

export default TrustWalletIntegration;
