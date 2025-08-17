import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { http, WagmiProvider, createConfig } from "wagmi";
import { mainnet, linea, lineaSepolia } from "wagmi/chains";
import { metaMask } from "wagmi/connectors";
const config = createConfig({
  ssr: true, // Make sure to enable this for server-side rendering (SSR) applications.
  chains: [mainnet, linea, lineaSepolia],
  connectors: [
    metaMask({
      infuraAPIKey: process.env.NEXT_PUBLIC_INFURA_API_KEY!,
    }),
  ],
  transports: {
    [mainnet.id]: http(),
    [linea.id]: http(),
    [lineaSepolia.id]: http(),
  },
});
