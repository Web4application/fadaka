import { useState } from 'react';
import { ethers } from 'ethers';

export default function TxForm() {
  const [keystore, setKeystore] = useState(null);
  const [password, setPassword] = useState('');
  const [wallet, setWallet] = useState(null);
  const [txHash, setTxHash] = useState('');
  const [form, setForm] = useState({
    rpcUrl: 'http://localhost:8545',
    to: '',
    value: '',
    gas: '21000',
    maxFee: '50',
    priorityFee: '2',
    nonce: '',
    chainId: '8888',
  });

  const handleChange = (e) => {
    setForm({...form, [e.target.name]: e.target.value});
  };

  const handleKeystore = (e) => {
    const file = e.target.files[0];
    const reader = new FileReader();
    reader.onload = async (event) => {
      try {
        const encryptedJson = event.target.result;
        const wallet = await ethers.Wallet.fromEncryptedJson(encryptedJson, password);
        setWallet(wallet);
        setTxHash("✅ Keystore Decrypted: " + wallet.address);
      } catch (err) {
        setTxHash("❌ Failed to decrypt: " + err.message);
      }
    };
    reader.readAsText(file);
  };

  const sendTx = async () => {
    if (!wallet) return alert("Wallet not loaded");

    const provider = new ethers.JsonRpcProvider(form.rpcUrl);
    const connectedWallet = wallet.connect(provider);

    try {
      const tx = {
        to: form.to,
        value: ethers.parseEther(form.value),
        gasLimit: BigInt(form.gas),
        maxFeePerGas: ethers.parseUnits(form.maxFee, "gwei"),
        maxPriorityFeePerGas: ethers.parseUnits(form.priorityFee, "gwei"),
        nonce: parseInt(form.nonce),
        type: 2,
        chainId: parseInt(form.chainId)
      };

      const sentTx = await connectedWallet.sendTransaction(tx);
      setTxHash("🚀 TX Sent: " + sentTx.hash);
    } catch (err) {
      setTxHash("❌ Error sending TX: " + err.message);
    }
  };

  return (
    <div className="bg-zinc-800 p-6 rounded-xl">
      <label>RPC URL</label>
      <input name="rpcUrl" value={form.rpcUrl} onChange={handleChange} />
      <label>Keystore File</label>
      <input type="file" onChange={handleKeystore} />
      <label>Password</label>
      <input type="password" value={password} onChange={e => setPassword(e.target.value)} />
      <label>To</label>
      <input name="to" value={form.to} onChange={handleChange} />
      <label>Value (ETH)</label>
      <input name="value" value={form.value} onChange={handleChange} />
      <label>Gas Limit</label>
      <input name="gas" value={form.gas} onChange={handleChange} />
      <label>Max Fee Per Gas (Gwei)</label>
      <input name="maxFee" value={form.maxFee} onChange={handleChange} />
      <label>Max Priority Fee (Gwei)</label>
      <input name="priorityFee" value={form.priorityFee} onChange={handleChange} />
      <label>Nonce</label>
      <input name="nonce" value={form.nonce} onChange={handleChange} />
      <label>Chain ID</label>
      <input name="chainId" value={form.chainId} onChange={handleChange} />

      <button onClick={sendTx} className="mt-4 bg-emerald-400 text-black px-4 py-2 rounded">Send TX</button>
      <pre className="mt-4">{txHash}</pre>
    </div>
  );
}
