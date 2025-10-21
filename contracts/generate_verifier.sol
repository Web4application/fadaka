// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IZKVerifier {
    function verifyProof(
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[] memory input
    ) external view returns (bool);
}

contract FadakaPrivateTransfers {
    IZKVerifier public verifier;

    event TransferVerified(address indexed sender, address indexed receiver, uint256 amount);

    constructor(address verifierAddress) {
        verifier = IZKVerifier(verifierAddress);
    }

    function submitTransfer(
        address sender,
        address receiver,
        uint256 amount,
        uint256[2] memory a,
        uint256[2][2] memory b,
        uint256[2] memory c,
        uint256[] memory input
    ) external {
        require(verifier.verifyProof(a, b, c, input), "Invalid zk-SNARK proof");
        emit TransferVerified(sender, receiver, amount);
    }
}
