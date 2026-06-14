# Khmer Lunar Calendar App
## កាលបរិច្ឆេទចន្ទគតិខ្មែរ

A beautiful desktop application for displaying Khmer Lunar Calendar dates with support for Windows and macOS.

## Features

- 📅 Display current Khmer lunar date
- 🌙 Moon phase information (កើត/រោច)
- 🐉 Zodiac animal year
- 🌕 Full moon and Sila day indicators
- 🎉 Khmer New Year date calculator
- 🌐 Bilingual support (Khmer/English)
- 📆 Date picker for any Gregorian date
- 💻 Native desktop support for Windows and macOS

## Prerequisites

- Flutter SDK (3.0 or higher)
- For Windows: Windows 10 or higher
- For macOS: macOS 10.14 or higher

## Installation

### 1. Clone or Download the Project

```bash
cd khmer_lunar_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Run the Application

#### For Windows:
```bash
flutter run -d windows
```

#### For macOS:
```bash
flutter run -d macos
```

## Building Release Versions

### Build for Windows

```bash
flutter build windows --release
```

The executable will be in: `build\windows\x64\runner\Release\khmer_lunar_app.exe`

### Build for macOS

```bash
flutter build macos --release
```

The app will be in: `build/macos/Build/Products/Release/khmer_lunar_app.app`

## Usage

1. **View Current Date**: The app automatically displays today's Khmer lunar date
2. **Select Different Date**: Click "Select Date" button to choose any date
3. **Toggle Language**: Click the language icon in the app bar to switch between Khmer and English
4. **Special Days**: Orange card appears on Sila days (ថ្ងៃសីល) and full moon days
5. **New Year Info**: Green card shows upcoming Khmer New Year dates

## Dependencies

- `flutter_khmer_chankitec: ^0.1.0` - Khmer lunar calendar calculations
- `intl: ^0.19.0` - Date formatting

## Khmer Lunar Calendar Features

### Main Information Displayed:
- Day of week (ថ្ងៃ)
- Lunar day with moon phase (កើត/រោច)
- Lunar month name (មិគសិរ, បុស្ស, etc.)
- Zodiac animal year (ជូត, ឆ្លូវ, រោង, etc.)
- Era (ឆស័ក, ឯកស័ក)
- Buddhist Era year (ពុទ្ធសករាជ)

### Special Days:
- **Sila Days** (ថ្ងៃសីល): 8កើត, 15កើត, 8រោច, 14/15រោច
- **Full Moon** (ពេញបូណ៌មី): 15កើត

### Khmer New Year:
- Automatic calculation of Moha Songkran date
- Shows 3-day or 4-day celebration (leap years)
- Displays dates for current and next year

## Screenshots

The app features:
- Clean, modern Material Design 3 interface
- Purple theme with color-coded cards
- Responsive layout for different window sizes
- Easy-to-read typography supporting Khmer Unicode

## License

This project is open source and available for personal and commercial use.

## Credits

Built with Flutter and the `flutter_khmer_chankitec` package.
