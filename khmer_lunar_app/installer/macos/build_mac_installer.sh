#!/bin/bash
# ─────────────────────────────────────────────────────────────────────────────
# Khmer Lunar Calendar – macOS build + DMG installer
# Requirements: macOS + Flutter + Xcode + (optional) create-dmg
#   Install create-dmg:  brew install create-dmg
# ─────────────────────────────────────────────────────────────────────────────
set -euo pipefail

APP_NAME="KhmerLunarCalendar"
BUNDLE_ID="com.khmer.lunarcalendar"
VERSION="1.0.0"
FLUTTER_APP_NAME="khmer_lunar_app"
BUILD_DIR="../../build/macos/Build/Products/Release"
DIST_DIR="../../dist/macos"
DMG_NAME="${APP_NAME}-${VERSION}.dmg"
APP_PATH="${BUILD_DIR}/${FLUTTER_APP_NAME}.app"

echo "══════════════════════════════════════════════"
echo "  Khmer Lunar Calendar – macOS Installer Build"
echo "══════════════════════════════════════════════"

# ── 0. Go to project root ────────────────────────────────────────────────────
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR/../.."

# ── 1. Flutter build ─────────────────────────────────────────────────────────
echo ""
echo "▶  Cleaning..."
flutter clean

echo "▶  Getting dependencies..."
flutter pub get

echo "▶  Building macOS release..."
flutter build macos --release

if [ ! -d "$APP_PATH" ]; then
  echo "✗  Build failed – .app not found at: $APP_PATH"
  exit 1
fi
echo "✓  Build complete: $APP_PATH"

# ── 2. Code signing ──────────────────────────────────────────────────────────
# Check for a real Developer ID (requires Apple Developer Program, $99/yr)
SIGNING_ID="${MACOS_SIGNING_ID:-}"

if [ -n "$SIGNING_ID" ]; then
  echo ""
  echo "▶  Signing with Developer ID: $SIGNING_ID"
  codesign --force --deep --sign "$SIGNING_ID" \
    --options runtime \
    --entitlements entitlements.plist \
    "$APP_PATH"
  echo "✓  Signed"
else
  echo ""
  echo "▶  Ad-hoc signing (no Developer ID found – set MACOS_SIGNING_ID env var for distribution)"
  codesign --force --deep --sign "-" "$APP_PATH"
  echo "✓  Ad-hoc signed"
fi

# ── 3. Create output directory ───────────────────────────────────────────────
mkdir -p "$DIST_DIR"
DMG_PATH="${DIST_DIR}/${DMG_NAME}"
[ -f "$DMG_PATH" ] && rm "$DMG_PATH"

# ── 4. Build DMG ─────────────────────────────────────────────────────────────
echo ""
if command -v create-dmg &>/dev/null; then
  echo "▶  Building styled DMG with create-dmg..."
  create-dmg \
    --volname "Khmer Lunar Calendar" \
    --window-pos 200 120 \
    --window-size 560 380 \
    --icon-size 100 \
    --icon "${FLUTTER_APP_NAME}.app" 140 190 \
    --hide-extension "${FLUTTER_APP_NAME}.app" \
    --app-drop-link 420 190 \
    --background /System/Library/Desktop\ Pictures/Solid\ Colors/Teal.png \
    "$DMG_PATH" \
    "$APP_PATH" 2>/dev/null || \
  create-dmg \
    --volname "Khmer Lunar Calendar" \
    --window-size 560 380 \
    --icon-size 100 \
    --icon "${FLUTTER_APP_NAME}.app" 140 190 \
    --hide-extension "${FLUTTER_APP_NAME}.app" \
    --app-drop-link 420 190 \
    "$DMG_PATH" \
    "$APP_PATH"
else
  echo "▶  Building DMG with hdiutil (install 'create-dmg' via brew for a prettier installer)..."
  # Temporary staging folder
  STAGING="/tmp/khmer_dmg_staging"
  rm -rf "$STAGING"
  mkdir -p "$STAGING"
  cp -r "$APP_PATH" "$STAGING/"
  ln -s /Applications "$STAGING/Applications"

  hdiutil create \
    -volname "Khmer Lunar Calendar" \
    -srcfolder "$STAGING" \
    -ov -format UDZO \
    "$DMG_PATH"

  rm -rf "$STAGING"
fi

echo "✓  DMG created: $DMG_PATH"

# ── 5. Optional notarization ─────────────────────────────────────────────────
if [ -n "$MACOS_APPLE_ID" ] && [ -n "$MACOS_TEAM_ID" ]; then
  echo ""
  echo "▶  Submitting for notarization..."
  xcrun notarytool submit "$DMG_PATH" \
    --apple-id "$MACOS_APPLE_ID" \
    --team-id "$MACOS_TEAM_ID" \
    --wait
  xcrun stapler staple "$DMG_PATH"
  echo "✓  Notarized and stapled"
else
  echo ""
  echo "ℹ   Skipping notarization (set MACOS_APPLE_ID and MACOS_TEAM_ID to notarize)"
fi

# ── 6. Summary ───────────────────────────────────────────────────────────────
SIZE=$(du -sh "$DMG_PATH" | cut -f1)
echo ""
echo "══════════════════════════════════════════════"
echo "  ✓  Done! Installer: dist/macos/${DMG_NAME}"
echo "  Size: ${SIZE}"
echo "══════════════════════════════════════════════"
echo ""
echo "  To distribute:"
echo "    Share: $DMG_PATH"
echo ""
echo "  Users install by:"
echo "    1. Double-click the .dmg to mount it"
echo "    2. Drag 'khmer_lunar_app' → Applications folder"
echo "    3. Eject the disk image"
echo "    4. Open from Applications (first time: right-click → Open)"
