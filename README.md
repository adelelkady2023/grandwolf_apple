# Grand Wolf Flutter App

This repository is a Flutter project prepared for Codemagic cloud builds.

## Online preview (recommended)

Use Codemagic workflow **`flutter_web_online_preview`** to build web and optionally deploy online.

### A) Artifact-only preview (no extra setup)
1. Run workflow `flutter_web_online_preview`.
2. Download artifact `build/web/**` from Codemagic.
3. Upload to any static host (Netlify, Vercel, Firebase Hosting, GitHub Pages).

### B) Direct online deploy from Codemagic to Netlify
Set these secure environment variables in Codemagic app settings:
- `NETLIFY_AUTH_TOKEN`
- `NETLIFY_SITE_ID`

Then run `flutter_web_online_preview`.
If both vars are set, Codemagic deploys `build/web` to your Netlify site automatically.

## View app on Windows locally

### Option 1: Run in Chrome
```bash
flutter doctor -v
flutter pub get
flutter config --enable-web
flutter run -d chrome
```

### Option 2: Run on Android emulator/device
```bash
flutter pub get
flutter run -d android
```

## iOS cloud build

Workflow `flutter_ios_no_codesign`:
- Generates missing iOS files if needed.
- Builds unsigned iOS app in Codemagic macOS environment.
