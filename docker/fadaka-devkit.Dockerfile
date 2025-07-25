FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# --- Base toolchain ---
RUN apt-get update && apt-get install -y \
    curl git wget unzip pkg-config libssl-dev build-essential \
    clang cmake python3 python3-pip libclang-dev \
    && rm -rf /var/lib/apt/lists/*

# --- Install Rust and wasm toolchain ---
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y
ENV PATH="/root/.cargo/bin:$PATH"
RUN rustup target add wasm32-unknown-unknown
RUN cargo install wasm-bindgen-cli

# --- Copy Fadaka source into container ---
WORKDIR /app
COPY . .

# --- Build WASM package ---
RUN cargo build --release --target wasm32-unknown-unknown \
 && wasm-bindgen \
      target/wasm32-unknown-unknown/release/fadaka_wasm.wasm \
      --out-dir pkg --target web
