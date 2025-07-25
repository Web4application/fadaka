# 1. Install foundry if not done
curl -L https://foundry.paradigm.xyz | bash && foundryup

# 2. Clone your repo or create the folder
mkdir fadaka-forge && cd fadaka-forge

# 3. Initialize foundry
forge init --force

# 4. Replace the files with above code

# 5. Install OpenZeppelin (ERC20 support)
forge install OpenZeppelin/openzeppelin-contracts

# 6. Run tests
forge test

# 7. Deploy to Fadaka chain
forge script script/Deploy.s.sol --rpc-url $FADAKA_RPC --broadcast --private-key $PRIVATE_KEY
