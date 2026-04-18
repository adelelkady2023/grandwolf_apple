# Grand Wolf Flutter App

This repository is a Flutter project prepared for Codemagic cloud builds.

## View the app on Windows (no macOS needed)

### Option 1: Run locally in Chrome (fastest way to view UI)
1. Install Flutter SDK (stable channel) and Chrome.
2. In project root, run:

```bash
flutter doctor -v
flutter pub get
flutter config --enable-web
flutter run -d chrome
```

### Option 2: Run locally on Android emulator/device
```bash
flutter pub get
flutter run -d android
```

### Option 3: Build web preview bundle
```bash
flutter pub get
flutter build web --release
```
Then open `build/web/index.html` in a local static server (for example VS Code Live Server).

## Codemagic workflows

### `flutter_ios_no_codesign`
- Generates missing iOS files when needed.
- Builds iOS unsigned (`--no-codesign`) on Codemagic macOS.

### `flutter_web_preview`
- Builds web release output.
- Uploads `build/web/**` as artifacts so you can download and preview.
