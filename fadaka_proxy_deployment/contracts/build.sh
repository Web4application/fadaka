#!/bin/bash
set -e
cargo build --release --target wasm32-unknown-unknown
wasm-bindgen target/wasm32-unknown-unknown/release/fadaka_wasm.wasm \
  --out-dir pkg --target web
# yarn
yarn

# npm
npm install

# pnpm
pnpm install --shamefully-hoist
