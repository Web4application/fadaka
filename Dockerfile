########################
# 1️⃣  Build stage
########################
FROM ubuntu:24.04 AS builder
ENV DEBIAN_FRONTEND=noninteractive

# ── Install toolchains ──────────────────────────────────────────────────
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential clang lld \
    cmake ninja-build pkg-config \
    nasm yasm                       \  # ← x86/x86‑64 standalone assembler
    golang-go git curl ca-certificates \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src
COPY . .

####################################################
# 1‑A: Build C/C++ (+ Assembly)  ────────────────────
####################################################
WORKDIR /src/cpp
# If your assembly is built by CMake directly (.S/.s), clang handles it.
# For .asm files with NASM syntax, see cmake snippet below.
RUN cmake -G Ninja -DCMAKE_BUILD_TYPE=Release \
            -DCMAKE_C_COMPILER=clang \
            -DCMAKE_CXX_COMPILER=clang++ \
            -DCMAKE_ASM_NASM_COMPILER=nasm \
            -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=ON \
            -DCMAKE_INSTALL_PREFIX=/opt/fadaka \
            .
RUN ninja && ninja install          # installs into /opt/fadaka/bin/

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
LABEL org.opencontainers.image.description="Fadaka Blockchain full‑stack node with assembly support"

RUN useradd -m -u 10001 fadaka
WORKDIR /app

COPY --from=builder /opt/fadaka /app
COPY scripts /app/scripts        # optional

EXPOSE 30303 8545 8546
USER fadaka

ENV PATH="/app/bin:${PATH}"

ENTRYPOINT ["fadaka-node"]
CMD ["node", "--config", "/app/config.toml"]

# escape=`
FROM mcr.microsoft.com/windows/servercore:ltsc2022 AS msvc-builder

RUN choco install -y visualstudio2022buildtools --package-parameters "--includeRecommended"
RUN setx PATH "%PATH%;C:\\Program Files\\Microsoft Visual Studio\\2022\\BuildTools\\VC\\Tools\\MSVC\\14.40.33806\\bin\\Hostx64\\x64"

WORKDIR C:\\src
COPY . .

# Build commands here (msbuild / cmake -G "Visual Studio 17 2022")
