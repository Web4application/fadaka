pragma circom 2.0.0;

template Transfer() {
    signal input senderBalance;
    signal input transferAmount;
    signal output valid;

    valid <== senderBalance >= transferAmount ? 1 : 0;
}

component main = Transfer();
