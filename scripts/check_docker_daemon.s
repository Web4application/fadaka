#!/bin/bash

CONFIG_PATH="/etc/docker/daemon.json"
EXPECTED_DATA_ROOT="/var/lib/fadaka-docker"
NEEDS_RESTART=false

mkdir -p "$(dirname $CONFIG_PATH)"

if [ -f "$CONFIG_PATH" ]; then
    CURRENT_DATA_ROOT=$(jq -r '.["data-root"]' $CONFIG_PATH)
    if [ "$CURRENT_DATA_ROOT" != "$EXPECTED_DATA_ROOT" ]; then
        echo "⚠️ Updating data-root for Fadaka..."
        jq --arg root "$EXPECTED_DATA_ROOT" '.["data-root"] = $root' $CONFIG_PATH > tmp.json && mv tmp.json $CONFIG_PATH
        NEEDS_RESTART=true
    fi
else
    echo "📁 Creating daemon.json for Fadaka..."
    cat <<EOF > $CONFIG_PATH
{
  "data-root": "$EXPECTED_DATA_ROOT",
  "experimental": true,
  "debug": false,
  "insecure-registries": ["localhost:5000"],
  "registry-mirrors": ["https://mirror.gcr.io"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m",
    "max-file": "3"
  }
}
EOF
    NEEDS_RESTART=true
fi

if $NEEDS_RESTART; then
    echo "🔄 Restarting Docker..."
    sudo systemctl restart docker
else
    echo "✅ Docker already configured for Fadaka."
fi
