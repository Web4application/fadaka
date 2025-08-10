#!/bin/bash
set -e

echo "🛠 Building macOS app..."
cd "$(dirname "$0")/../macos-app"

xcodebuild -scheme MyApp -archivePath build/MyApp.xcarchive archive

echo "🔏 Exporting signed app..."
xcodebuild -exportArchive \
  -archivePath build/MyApp.xcarchive \
  -exportPath build/MyAppExport \
  -exportOptionsPlist ../exportOptions.plist

echo "✅ macOS app built and signed."
