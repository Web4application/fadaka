npx hardhat run scripts/deploy.js --network <fadaka-blockchain>

cd Fadaka-blockchain/ai_tools
python generate_readme.py       # Generates README.generated.md
python docgen_py.py             # Generates .doc.md for Python files
python docgen_go.py             # Generates .doc.md for Go files

git clone https://github.com/Web4application/script_analyzer_bot.git
cd script_analyzer_bot
pip install -r requirements.txt


## Running the API

uvicorn app.main:app --reload
http://127.0.0.1:8000/docs

import "github.com/ethereum/dapp-bin/library/math.sol

solc github.com/ethereum/dapp-bin/=dapp-bin/ --base-path /project source.sol
