########################
# 1️⃣  Build stage
########################
FROM ubuntu:24.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

# ── Install toolchains ────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential cmake ninja-build pkg-config \
    clang lld \
    git curl ca-certificates \
    golang-go \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# ── Copy source
COPY . .

####################################################
# 1‑A: Build C/C++ components (Release + LTO) ──────
####################################################
WORKDIR /src/cpp
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_C_COMPILER=clang \
            -DCMAKE_CXX_COMPILER=clang++ \
            -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
            -DCMAKE_INSTALL_PREFIX=/opt/fadaka \
            .
RUN ninja && ninja install      # installs into /opt/fadaka/bin/

####################################################
# 1‑B: Build Go components  ─────────────────────────
####################################################
WORKDIR /src
ENV CGO_ENABLED=0 GOOS=linux GOARCH=amd64
RUN go build -ldflags="-s -w" -o /opt/fadaka/bin/fadaka-node ./cmd/fadaka

########################
# 2️⃣  Runtime stage
########################
FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/Web4application/fadaka-blockchain"
LABEL org.opencontainers.image.description="Fadaka Blockchain full‑stack node"

# Add a non‑root user (optional but recommended)
RUN useradd -m -u 10001 fadaka

WORKDIR /app
COPY --from=builder /opt/fadaka /app

# Copy shell helpers (if any)
COPY scripts /app/scripts

# Expose typical P2P / RPC ports (edit as needed)
EXPOSE 30303 8545 8546

USER fadaka

ENV PATH="/app/bin:${PATH}"

ENTRYPOINT ["fadaka-node"]
CMD ["node", "--config", "/app/config.toml"]
