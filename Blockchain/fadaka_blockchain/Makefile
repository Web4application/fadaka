all: cpp python go solidity

cpp:
	g++ -std=c++17 -Wall -o build/fadaka src/main.cpp

python:
	python3 -m flake8 api/

go:
	cd go/cmd/fadaka-node && go build

solidity:
	npx hardhat compile
