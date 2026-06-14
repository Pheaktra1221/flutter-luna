# How to Install – Khmer Lunar Calendar
## របៀបដំឡើង – ប្រតិទិនចន្ទគតិខ្មែរ

---

## Windows

### Option A – Use the ready-made installer (easiest)

1. Go to `dist/windows/`
2. Double-click **`KhmerLunarCalendar-1.0.0-Setup.exe`**
3. Follow the wizard (Next → Next → Install)
4. Tick "Create desktop shortcut" if you want one
5. Click **Finish** — the app launches automatically

The installer puts the app in `C:\Users\<you>\AppData\Local\Programs\Khmer Lunar Calendar\`  
and adds an entry to Start Menu and (optionally) Desktop.

**To uninstall:** Settings → Apps → search "Khmer" → Uninstall

---

### Option B – Rebuild the installer from source

Requirements: Flutter SDK + Inno Setup 6 ([download](https://jrsoftware.org/isdl.php))

```powershell
# From the project root (khmer_lunar_app/)
.\installer\windows\build_windows_installer.ps1
```

This cleans, rebuilds the Flutter app, then compiles a fresh installer at  
`dist\windows\KhmerLunarCalendar-1.0.0-Setup.exe`

---

## macOS

> macOS builds must be done **on a Mac**. You cannot cross-compile from Windows.

### Option A – Build the DMG on your Mac

**Prerequisites**
```bash
# Flutter (if not installed)
# https://docs.flutter.dev/get-started/install/macos

# Xcode (from App Store, then accept license)
sudo xcodebuild -license accept

# Optional: prettier DMG layout
brew install create-dmg
```

**Build**
```bash
cd khmer_lunar_app
bash installer/macos/build_mac_installer.sh
```

Output: `dist/macos/KhmerLunarCalendar-1.0.0.dmg`

---

### Option B – Run directly without building a DMG

```bash
cd khmer_lunar_app
flutter pub get
flutter build macos
open build/macos/Build/Products/Release/khmer_lunar_app.app
```

---

### Installing the DMG

1. Double-click **`KhmerLunarCalendar-1.0.0.dmg`** to mount it
2. Drag **khmer_lunar_app** → **Applications** folder shortcut
3. Eject the disk image (drag it to Trash or press ⌘E)
4. Open **Launchpad** or **Applications** and launch the app

**First-time Gatekeeper warning** (if app is not notarized):
- Right-click the app → **Open** → click **Open** in the dialog
- This only needs to be done once

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Windows: "Windows protected your PC" | Click "More info" → "Run anyway" |
| macOS: "app is damaged" | Run: `xattr -cr /Applications/khmer_lunar_app.app` |
| macOS: Gatekeeper blocks app | Right-click → Open (first launch only) |
| Flutter not found | Install from [flutter.dev](https://docs.flutter.dev/get-started/install) |
| `flutter build macos` fails | Run `flutter doctor` and fix any Xcode issues |
| Inno Setup not found | Install from [jrsoftware.org](https://jrsoftware.org/isdl.php) |

---

## File locations after install

### Windows
```
C:\Users\<you>\AppData\Local\Programs\Khmer Lunar Calendar\
├── khmer_lunar_app.exe
├── flutter_windows.dll
└── data\
    ├── app.so
    ├── icudtl.dat
    └── flutter_assets\
```

### macOS
```
/Applications/khmer_lunar_app.app/
└── Contents/
    ├── MacOS/khmer_lunar_app   (executable)
    ├── Frameworks/             (Flutter engine)
    └── Resources/              (assets)
```
