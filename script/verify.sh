#!/usr/bin/env bash
set -euo pipefail

CHECKSUM_FILE="SHA256SUMS"
echo "🔍 Verifying Fadaka build dependencies..."

if [ ! -f "$CHECKSUM_FILE" ]; then
    echo "❌ Missing checksum manifest: $CHECKSUM_FILE"
    exit 1
fi

sha256sum -c "$CHECKSUM_FILE" --ignore-missing

echo "✅ All verified — build environment is clean and trusted."
