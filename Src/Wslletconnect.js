import UniversalProvider from '@walletconnect/universal-provider'

//  Initialize the provider
const provider = await UniversalProvider.init({
  projectId: '0271de3ff9471b2d5f64c6ff72bab0e7',
  metadata: {
    name: 'web4app',
    description: 'React App for WalletConnect',
    url: 'https://walletconnect.com/',
    icons: ['https://avatars.githubusercontent.com/u/37784886']
  },
  client: undefined // optional instance of @walletconnect/sign-client
})

//  create sub providers for each namespace/chain
await provider.connect({
  optionalNamespaces: {
    eip155: {
      methods: [
        'eth_sendTransaction',
        'eth_signTransaction',
        'eth_sign',
        'personal_sign',
        'eth_signTypedData'
      ],
      chains: ['eip155:80001'],
      events: ['chainChanged', 'accountsChanged'],
      rpcMap: {
        80001:
          'https://rpc.walletconnect.com?chainId=eip155:80001&projectId=<0271de3ff9471b2d5f64c6ff72bab0e7>'
      }
    }
  },
  pairingTopic: '<123...topic>', // optional topic to connect to
  skipPairing: false // optional to skip pairing ( later it can be resumed by invoking .pair())
})

import { ReactNode, useMemo, useState } from 'react'
import { ConnectionProvider, WalletProvider } from '@solana/wallet-adapter-react'
import { WalletAdapterNetwork } from '@solana/wallet-adapter-base'
import { WalletModalProvider } from '@solana/wallet-adapter-react-ui'
import { clusterApiUrl } from '@solana/web3.js'

import '@solana/wallet-adapter-react-ui/styles.css'

import { WalletConnectWalletAdapter } from '@walletconnect/solana-adapter'

export const SolanaContext = ({ children }: { children: ReactNode }) => {
	const endpoint = useMemo(() => clusterApiUrl(WalletAdapterNetwork.Mainnet), [])

	const wallets = useMemo(
		() => [
			new WalletConnectWalletAdapter({
				network: WalletAdapterNetwork.Mainnet,
				options: {
					projectId: '0271de3ff9471b2d5f64c6ff72bab0e7',
				},
			}),
		],
		// eslint-disable-next-line react-hooks/exhaustive-deps
