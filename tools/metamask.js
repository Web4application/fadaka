import detectEthereumProvider from '@metamask/detect-provider';

async function connectMetaMask() {
  const provider = await detectEthereumProvider();

  if (provider) {
    console.log('MetaMask is installed!');
    await provider.request({ method: 'eth_requestAccounts' });
  } else {
    console.log('Please install MetaMask!');
  }
}

export default connectMetaMask;
