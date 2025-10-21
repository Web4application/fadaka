circom transfer.circom --wasm --r1cs
snarkjs groth16 setup transfer.r1cs pot12_final.ptau transfer_0000.zkey
snarkjs zkey contribute transfer_0000.zkey transfer_final.zkey --name="Fadaka Setup"
snarkjs zkey export verificationkey transfer_final.zkey verification_key.json
snarkjs generateverifier transfer_final.zkey FadakaVerifier.sol
