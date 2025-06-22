npx hardhat run scripts/deploy.js --network <fadaka-blockchain>

cd Fadaka-blockchain/ai_tools
python generate_readme.py       # Generates README.generated.md
python docgen_py.py             # Generates .doc.md for Python files
python docgen_go.py             # Generates .doc.md for Go files
