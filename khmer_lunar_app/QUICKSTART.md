# Quick Start Guide - Khmer Lunar Calendar App

## Windows Installation (Quick Steps)

1. **Open Terminal** in the project folder
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run -d windows
   ```

4. **Build installer** (optional):
   ```bash
   flutter build windows --release
   ```
   Find the app at: `build\windows\x64\runner\Release\khmer_lunar_app.exe`

## macOS Installation (Quick Steps)

1. **Open Terminal** in the project folder
2. **Install dependencies**:
   ```bash
   flutter pub get
   ```
3. **Run the app**:
   ```bash
   flutter run -d macos
   ```

4. **Build app bundle** (optional):
   ```bash
   flutter build macos --release
   ```
   Find the app at: `build/macos/Build/Products/Release/khmer_lunar_app.app`

## Troubleshooting

### Flutter not found
Install Flutter from: https://docs.flutter.dev/get-started/install

### No devices available
- **Windows**: Ensure you have Windows 10+ and Visual Studio build tools
- **macOS**: Ensure you have Xcode installed

### Dependencies error
Run: `flutter clean` then `flutter pub get`

## Using the App

- **Main Screen**: Shows current Khmer lunar date automatically
- **Change Date**: Click "Select Date" button
- **Change Language**: Click language icon (top right)
- **Special Days**: Orange card shows when it's a Sila day or full moon
- **New Year**: Green card displays Khmer New Year information

## Distribution

### Windows
Share the entire `Release` folder with:
- `khmer_lunar_app.exe`
- All `.dll` files
- `data` folder

### macOS
Share the `.app` file directly. Users may need to:
1. Right-click the app
2. Select "Open"
3. Confirm to bypass Gatekeeper (first time only)

For notarized distribution, you'll need an Apple Developer account.
