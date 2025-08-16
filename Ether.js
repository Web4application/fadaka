const chains = [42161, 8453, 10, 534352, 81457]

for (const chain of chains) {

  // endpoint accepts one chain at a time, loop for all your chains
  const balance = fetch(`https://api.etherscan.io/v2/api?
     chainid=${chain}
     &module=account
     &action=balance
     &address=0x9BF1810999cf0b79bEec235308F272567064f966
     &tag=latest&apikey=GDAMWE2GTPPG8NN3QBHQ1E57RJE4DR4H2N`)
     
}
