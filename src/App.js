import React, { useState, useEffect } from 'react';
import { ethers } from 'ethers';
import CryptoJS from 'crypto-js';
import QRCode from 'qrcode.react';

const NETWORKS = {
  testnet: {
    name: 'Fadaka Testnet',
    rpc: 'https://testnet.fadaka.io/rpc',
  },
  mainnet: {
    name: 'Fadaka Mainnet',
    rpc: 'https://mainnet.fadaka.io/rpc', // Replace with real RPC
  },
};

const STORAGE_KEY = 'fadaka_wallet_encrypted';

export default function FadakaWallet() {
  const [network, setNetwork] = useState('testnet');
  const [wallet, setWallet] = useState(null);
  const [balance, setBalance] = useState(null);
  const [recipient, setRecipient] = useState('');
  const [sendAmount, setSendAmount] = useState('');
  const [txStatus, setTxStatus] = useState('');
  const [password, setPassword] = useState('');
  const [mode, setMode] = useState('generate'); // 'generate' or 'load'
  const [loadPrivateKey, setLoadPrivateKey] = useState('');

  // Encryption helpers using password
  const encrypt = (text, pass) => CryptoJS.AES.encrypt(text, pass).toString();
  const decrypt = (cipher, pass) => {
    try {
      const bytes = CryptoJS.AES.decrypt(cipher, pass);
      return bytes.toString(CryptoJS.enc.Utf8);
    } catch {
      return null;
    }
  };

  // Load wallet from localStorage using password
  const loadWalletFromStorage = () => {
    if (!password) {
      alert('Enter password to decrypt wallet');
      return;
    }
    const saved = localStorage.getItem(STORAGE_KEY);
    if (!saved) {
      alert('No wallet saved');
      return;
    }
    const parsed = JSON.parse(saved);
    const decryptedPK = decrypt(parsed.privateKey, password);
    if (!decryptedPK) {
      alert('Incorrect password or corrupted data');
      return;
    }
    setWallet({ address: parsed.address, privateKey: decryptedPK });
    setTxStatus('');
  };

  // Save wallet encrypted with password
  const saveWalletToStorage = (newWallet, pass) => {
    const encryptedPK = encrypt(newWallet.privateKey, pass);
    localStorage.setItem(STORAGE_KEY, JSON.stringify({
      address: newWallet.address,
      privateKey: encryptedPK,
    }));
  };

  // Generate wallet with password
  const generateWallet = () => {
    if (!password) {
      alert('Enter a password to encrypt your wallet');
      return;
    }
    const newWallet = ethers.Wallet.createRandom();
    setWallet(newWallet);
    setBalance(null);
    setTxStatus('');
    saveWalletToStorage(newWallet, password);
  };

  // Clear wallet and all data
  const clearWallet = () => {
    localStorage.removeItem(STORAGE_KEY);
    setWallet(null);
    setBalance(null);
    setTxStatus('');
    setRecipient('');
    setSendAmount('');
    setPassword('');
    setLoadPrivateKey('');
  };

  // Fetch balance when wallet or network changes
  useEffect(() => {
    if (!wallet) {
      setBalance(null);
      return;
    }
    const provider = new ethers.providers.JsonRpcProvider(NETWORKS[network].rpc);
    provider.getBalance(wallet.address)
      .then(bal => setBalance(ethers.utils.formatEther(bal)))
      .catch(() => setBalance(null));
  }, [wallet, network]);

  // Send transaction
  const sendTransaction = async () => {
    if (!wallet) return alert('Generate or load a wallet first!');
    if (!ethers.utils.isAddress(recipient)) return alert('Invalid recipient address!');
    if (isNaN(parseFloat(sendAmount)) || parseFloat(sendAmount) <= 0) return alert('Invalid amount!');

    setTxStatus('Sending transaction...');
    try {
      const provider = new ethers.providers.JsonRpcProvider(NETWORKS[network].rpc);
      const signer = new ethers.Wallet(wallet.privateKey, provider);

      const tx = await signer.sendTransaction({
        to: recipient,
        value: ethers.utils.parseEther(sendAmount),
      });

      await tx.wait();
      setTxStatus(`Transaction successful! Hash: ${tx.hash}`);

      // Refresh balance
      const bal = await provider.getBalance(wallet.address);
      setBalance(ethers.utils.formatEther(bal));
    } catch (err) {
      setTxStatus(`Transaction failed: ${err.message}`);
    }
  };

  // Load wallet from private key input and password
  const loadWalletFromPK = () => {
    if (!loadPrivateKey || !password) {
      alert('Enter private key and password');
      return;
    }
    try {
      const w = new ethers.Wallet(loadPrivateKey.trim());
      setWallet(w);
      saveWalletToStorage(w, password);
      setTxStatus('Wallet loaded and saved!');
    } catch {
      alert('Invalid private key');
    }
  };

  return (
    <div style={{ maxWidth: 480, margin: 'auto', padding: 20, fontFamily: 'Arial, sans-serif' }}>
      <h2>Fadaka Wallet Manager</h2>

      <div style={{ marginBottom: 10 }}>
        <label>
          Network:{' '}
          <select
            value={network}
            onChange={e => setNetwork(e.target.value)}
            style={{ padding: 5 }}
          >
            {Object.entries(NETWORKS).map(([key, val]) => (
              <option key={key} value={key}>{val.name}</option>
            ))}
          </select>
        </label>
      </div>

      <div style={{ marginBottom: 10 }}>
        <label>
          <input
            type="radio"
            checked={mode === 'generate'}
            onChange={() => setMode('generate')}
          /> Generate Wallet
        </label>{' '}
        <label>
          <input
            type="radio"
            checked={mode === 'load'}
            onChange={() => setMode('load')}
          /> Load Wallet (Private Key)
        </label>
      </div>

      <div style={{ marginBottom: 15 }}>
        <input
          type="password"
          placeholder="Password (for encrypt/decrypt)"
          value={password}
          onChange={e => setPassword(e.target.value)}
          style={{ width: '100%', padding: 8, marginBottom: 10 }}
        />

        {mode === 'load' && (
          <textarea
            placeholder="Enter your private key here"
            value={loadPrivateKey}
            onChange={e => setLoadPrivateKey(e.target.value)}
            rows={3}
            style={{ width: '100%', padding: 8, marginBottom: 10, fontFamily: 'monospace' }}
          />
        )}

        {mode === 'generate' ? (
          <button onClick={generateWallet} style={{ padding: '10px 20px' }}>
            Generate Wallet
          </button>
        ) : (
          <button onClick={loadWalletFromPK} style={{ padding: '10px 20px' }}>
            Load Wallet
          </button>
        )}
      </div>

      {wallet && (
        <>
          <button
            onClick={clearWallet}
            style={{ padding: '8px 16px', marginBottom: 20, background: '#e44', color: '#fff' }}
          >
            Clear Wallet
          </button>

          <div>
            <strong>Address:</strong>
            <p style={{ wordBreak: 'break-word', background: '#f0f0f0', padding: 10 }}>{wallet.address}</p>
            <QRCode value={wallet.address} size={128} />
          </div>

          <div>
            <strong>Private Key (Keep Secret!):</strong>
            <p style={{ wordBreak: 'break-word', background: '#fee', padding: 10, color: 'red' }}>
              {wallet.privateKey}
            </p>
          </div>

          <div>
            <strong>Balance ({NETWORKS[network].name}):</strong> {balance !== null ? `${balance} FDK` : 'Loading...'}
          </div>

          <hr style={{ margin: '20px 0' }} />

          <div>
            <input
              type="text"
              placeholder="Recipient Address"
              value={recipient}
              onChange={e => setRecipient(e.target.value)}
              style={{ width: '100%', padding: 8, marginBottom: 10 }}
            />
            <input
              type="number"
              placeholder="Amount to Send"
              value={sendAmount}
              onChange={e => setSendAmount(e.target.value)}
              style={{ width: '100%', padding: 8, marginBottom: 10 }}
              min="0"
              step="any"
            />
            <button onClick={sendTransaction} style={{ padding: '10px 20px' }}>
              Send Transaction
            </button>
          </div>

          {txStatus && <p style={{ marginTop: 20 }}>{txStatus}</p>}
        </>
      )}
    </div>
  );
}
