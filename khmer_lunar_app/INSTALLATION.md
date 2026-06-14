# Installation Guide - Khmer Lunar Calendar App

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Windows Installation](#windows-installation)
3. [macOS Installation](#macos-installation)
4. [Building for Distribution](#building-for-distribution)
5. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Install Flutter SDK

#### Windows
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/windows
2. Extract to `C:\src\flutter`
3. Add to PATH: `C:\src\flutter\bin`
4. Install Visual Studio 2022 with "Desktop development with C++"

#### macOS
1. Download Flutter SDK from: https://docs.flutter.dev/get-started/install/macos
2. Extract to home directory
3. Add to PATH in `~/.zshrc`:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```
4. Install Xcode from App Store
5. Run: `sudo xcodebuild -license`

### Verify Flutter Installation
```bash
flutter doctor
```

Ensure no critical issues for your target platform.

---

## Windows Installation

### Step 1: Navigate to Project
```bash
cd khmer_lunar_app
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Run in Development Mode
```bash
flutter run -d windows
```

### Step 4: Build Release Version
```bash
flutter build windows --release
```

**Output Location:** `build\windows\x64\runner\Release\`

### Step 5: Run the Executable
Double-click: `khmer_lunar_app.exe`

---

## macOS Installation

### Step 1: Navigate to Project
```bash
cd khmer_lunar_app
```

### Step 2: Get Dependencies
```bash
flutter pub get
```

### Step 3: Enable macOS Desktop
```bash
flutter config --enable-macos-desktop
```

### Step 4: Run in Development Mode
```bash
flutter run -d macos
```

### Step 5: Build Release Version
```bash
flutter build macos --release
```

**Output Location:** `build/macos/Build/Products/Release/khmer_lunar_app.app`

### Step 6: Run the App
Double-click: `khmer_lunar_app.app`

---

## Building for Distribution

### Windows Distribution

The release folder contains everything needed:
```
Release/
├── khmer_lunar_app.exe
├── flutter_windows.dll
├── data/
│   ├── icudtl.dat
│   └── flutter_assets/
└── [other DLL files]
```

**To Distribute:**
1. Zip the entire `Release` folder
2. Share with users
3. Users extract and run `khmer_lunar_app.exe`

**Optional - Create Installer:**
Use Inno Setup or NSIS to create a proper installer.

### macOS Distribution

**Option 1: Share .app Bundle**
1. Compress `khmer_lunar_app.app`
2. Share the zip file
3. Users extract and may need to:
   - Right-click → Open (first time only)
   - This bypasses Gatekeeper warning

**Option 2: Code Signing (Requires Apple Developer Account)**
```bash
codesign --force --deep --sign "Developer ID Application: Your Name" khmer_lunar_app.app
```

**Option 3: Notarization (Recommended for Distribution)**
Requires Apple Developer Program membership ($99/year)

---

## Troubleshooting

### Windows Issues

**Problem: "Visual Studio not found"**
- Install Visual Studio 2022
- Select "Desktop development with C++"
- Run `flutter doctor` to verify

**Problem: "Windows SDK not found"**
- Install Windows 10/11 SDK via Visual Studio Installer
- Select Windows 10 SDK component

**Problem: "flutter command not found"**
- Add Flutter to PATH: `C:\src\flutter\bin`
- Restart terminal

### macOS Issues

**Problem: "Xcode not found"**
- Install Xcode from App Store
- Run: `sudo xcodebuild -license`
- Run: `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`

**Problem: "CocoaPods not installed"**
```bash
sudo gem install cocoapods
```

**Problem: "App is damaged and can't be opened"**
- Right-click app → Open
- Or remove quarantine:
```bash
xattr -cr khmer_lunar_app.app
```

**Problem: "flutter command not found"**
- Add Flutter to PATH in `~/.zshrc`
- Run: `source ~/.zshrc`

### General Issues

**Problem: "Package download fails"**
```bash
flutter pub cache repair
flutter pub get
```

**Problem: "Build fails after Flutter upgrade"**
```bash
flutter clean
flutter pub get
flutter build [platform]
```

**Problem: "Hot reload not working"**
- This is normal for desktop apps
- Restart the app completely

---

## App Features Verification

After installation, verify these features work:

✓ Current date displays automatically  
✓ Date picker opens and allows selection  
✓ Language toggle switches between Khmer/English  
✓ Special days card appears on appropriate dates  
✓ New Year information displays correctly  
✓ Window can be resized  

---

## Performance Notes

- **First Launch**: May take 2-5 seconds (Flutter initializes)
- **Subsequent Launches**: Under 2 seconds
- **Memory Usage**: Approximately 100-150 MB
- **Disk Space**: 
  - Windows: ~30 MB
  - macOS: ~25 MB

---

## Support

For issues specific to:
- **Flutter**: https://docs.flutter.dev/
- **Khmer Chankitec Package**: https://pub.dev/packages/flutter_khmer_chankitec

For app-specific issues, check:
- README.md for feature documentation
- QUICKSTART.md for quick commands
