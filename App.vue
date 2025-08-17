<script setup lang="ts">
import Home from "./Home.vue";
import { Web3AuthProvider } from "@web3auth/modal/vue";
import { WagmiProvider } from "@web3auth/modal/vue/wagmi";
import web3AuthContextConfig from "./web3authContext";

</script>

<template>
  <div class="min-h-screen flex flex-col">
    <Web3AuthProvider :config="web3AuthContextConfig">
		<WagmiProvider>
			<Home />
		</WagmiProvider>
    </Web3AuthProvider>
  </div>
</template>
