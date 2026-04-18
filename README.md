# Grand Wolf Flutter App

This repository is a Flutter project prepared for Codemagic cloud builds.

## How to view the iOS app (without a Mac)

Use workflow **`flutter_ios_preview_online`** in Codemagic.

### Option A (recommended): Browser iOS preview with Appetize
1. Create an account at https://appetize.io.
2. Add `APPETIZE_API_TOKEN` in Codemagic environment variables (secure).
3. Run workflow `flutter_ios_preview_online`.
4. Codemagic will build an iOS simulator app (`Runner-simulator.zip`) and upload it to Appetize.
5. Open the Appetize link to interact with your iOS app in browser.

### Option B: Manual upload to Appetize
1. Run workflow `flutter_ios_preview_online`.
2. Download artifact `build/ios/iphonesimulator/Runner-simulator.zip`.
3. Upload zip manually to Appetize and open generated preview link.

> Note: `flutter_ios_no_codesign` is for unsigned device build and is not directly installable on iPhone.

## Online web preview

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
