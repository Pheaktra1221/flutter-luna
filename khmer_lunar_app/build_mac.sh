#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# Khmer Lunar Calendar – macOS build & DMG installer script
# Run this on a Mac with Flutter + Xcode installed
# ─────────────────────────────────────────────────────────────────────────────

set -e

APP_NAME="KhmerLunarCalendar"
BUNDLE_NAME="khmer_lunar_app"
VERSION="1.0.0"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"
BUILD_DIR="build/macos/Build/Products/Release"
DIST_DIR="dist"

echo "▶  Cleaning previous build..."
flutter clean

echo "▶  Getting dependencies..."
flutter pub get

echo "▶  Building macOS release bundle..."
flutter build macos

APP_PATH="${BUILD_DIR}/${BUNDLE_NAME}.app"

if [ ! -d "$APP_PATH" ]; then
  echo "✗ Build failed – .app not found at $APP_PATH"
  exit 1
fi

echo "✓  Built: $APP_PATH"

# ── Optional: ad-hoc code sign (no Apple Developer account needed) ──────────
echo "▶  Ad-hoc code signing..."
codesign --force --deep --sign "-" "$APP_PATH"
echo "✓  Signed (ad-hoc)"

# ── Create DMG ───────────────────────────────────────────────────────────────
mkdir -p "$DIST_DIR"
DMG_PATH="${DIST_DIR}/${DMG_NAME}"

echo "▶  Creating DMG installer..."

# Check if create-dmg is available
if command -v create-dmg &>/dev/null; then
  create-dmg \
    --volname "$APP_NAME" \
    --volicon "$APP_PATH/Contents/Resources/AppIcon.icns" \
    --window-pos 200 120 \
    --window-size 600 400 \
    --icon-size 100 \
    --icon "${BUNDLE_NAME}.app" 175 190 \
    --hide-extension "${BUNDLE_NAME}.app" \
    --app-drop-link 425 190 \
    "$DMG_PATH" \
    "$APP_PATH"
else
  # Fallback: plain hdiutil DMG without pretty layout
  hdiutil create \
    -volname "$APP_NAME" \
    -srcfolder "$APP_PATH" \
    -ov -format UDZO \
    "$DMG_PATH"
fi

echo ""
echo "✓  DMG installer created: $DMG_PATH"
echo ""
echo "  To distribute:"
echo "    1. Share $DMG_PATH with users"
echo "    2. Users double-click to mount, drag app to /Applications"
echo "    3. First launch: right-click → Open to bypass Gatekeeper"
echo ""
echo "  Optional – notarize for seamless install (requires Apple Developer account):"
echo "    xcrun notarytool submit $DMG_PATH --apple-id YOUR@EMAIL --team-id TEAMID --wait"
