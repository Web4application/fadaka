#!/bin/bash
echo "🔧 Setting up Docker for Fadaka..."

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    chmod +x ./scripts/check_docker_daemon.sh
    sudo ./scripts/check_docker_daemon.sh
else
    echo "❌ This installer is for Linux only. Use PowerShell script on Windows."
    exit 1
fi
