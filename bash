#!/usr/bin/env bash
# Smart profitability-based miner controller

CUSTOM_WALLET="web4.331855"
CUSTOM_POOL="us-south01.miningrigrentals.com:3344"
CUSTOM_POOL2="us-east01.miningrigrentals.com:3344"
CUSTOM_GPU="all"

# 1. Detect GPUs
declare -a GPUS
# NVIDIA
if command -v nvidia-smi &>/dev/null; then
    mapfile -t NVIDIA_IDS < <(nvidia-smi --query-gpu=index --format=csv,noheader)
    GPUS+=("${NVIDIA_IDS[@]}")
fi
# AMD
mapfile -t AMD_IDS < <(lspci | grep -i 'VGA' | grep -i 'AMD' | awk '{print $1}')
GPUS+=("${AMD_IDS[@]}")

# 2. Fetch current profitability (example API returning JSON)
PROFIT_JSON=$(curl -s "https://whattomine.com/coins.json")

# 3. Parse and sort algorithms by profitability
# For simplicity, example using jq (must be installed)
declare -A ALGOS
ALGOS["ethash"]=$(echo $PROFIT_JSON | jq '.coins.ETH.profitability')
ALGOS["etchash"]=$(echo $PROFIT_JSON | jq '.coins.ETC.profitability')
ALGOS["autolykos2"]=$(echo $PROFIT_JSON | jq '.coins.ERG.profitability')
ALGOS["ton"]=$(echo $PROFIT_JSON | jq '.coins.TON.profitability')

# Sort algorithms by descending profitability
SORTED_ALGOS=($(for k in "${!ALGOS[@]}"; do echo "$k ${ALGOS[$k]}"; done | sort -k2 -nr | awk '{print $1}'))

# 4. Build SRBMiner-MULTI command per GPU
SRB_CMD="SRBMiner-MULTI"
for gpu in "${GPUS[@]}"; do
    # Join sorted algos as comma-separated fallback list
    ALGO_LIST=$(IFS=, ; echo "${SORTED_ALGOS[*]}")
    SRB_CMD+=" --algorithm $ALGO_LIST --devices $gpu"
done

# 5. Add pools, wallet
SRB_CMD+=" --pool $CUSTOM_POOL --wallet $CUSTOM_WALLET --password x"
[[ -n "$CUSTOM_POOL2" ]] && SRB_CMD+=" --failover $CUSTOM_POOL2 --wallet $CUSTOM_WALLET --password x"

# 6. Print final command
echo "===== Smart Profitability Mining Command ====="
echo "$SRB_CMD"
echo "============================================="
