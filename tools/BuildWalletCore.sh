#!/bin/bash
docker build -f docker/wallet-core.Dockerfile -t fadaka-wallet-core .
docker run --rm -v $(pwd)/dist:/out fadaka-wallet-core bash -c "
  mkdir -p /out && \
  cp build/libTrustWalletCore.a /out && \
  cp build/libWalletCoreWasm.* /out || true
"
