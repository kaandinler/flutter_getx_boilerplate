# getx_boilerplate

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## When you fetch the project, you should run the terminal code at root directory

flutter pub run build_runner watch --delete-conflicting-outputs

flutter run --flavor dev -t lib/main_dev

## Bundle scripts

flutter build appbundle -t lib/main_prod.dart --flavor prod

flutter build apk --flavor dev -t lib/main_dev.dart

flutter build ipa -t lib/main_prod.dart --flavor prod

## Update icon

flutter pub run flutter_launcher_icons:main

## Update splash

flutter pub run flutter_native_splash:create

## Release test

flutter run --release --verbose --flavor dev -t lib/main_dev.dart

## Build & Publish (CI)

- CI sadece `main` branch'ine merge edilen Pull Request'lerde tetiklenir.
- Android: prod AAB üretilir ve Google Play'e yayınlanır; track ve rollout oranı env ile kontrol edilir.
- iOS: IPA üretilir; TestFlight veya App Store review submission env ile kontrol edilir.
- Her iki job da gerekli Secrets mevcutsa yayın adımlarını çalıştırır; değilse sadece build artifact üretir.

Google Play publish (CI)
- Secrets required for signed builds and upload:
  - `ANDROID_KEYSTORE_BASE64` base64 of your `release.keystore`
  - `ANDROID_KEYSTORE_PASSWORD` keystore password
  - `ANDROID_KEY_ALIAS` key alias
  - `ANDROID_KEY_PASSWORD` key password
  - `PLAY_SERVICE_ACCOUNT_JSON` JSON of Google Play service account (plaintext)
- Yayın davranışı env ile:
  - `PUBLISH_TRACK` `internal|production` (default: `internal`)
  - `ANDROID_ROLLOUT_FRACTION` (örn. `0.1` → %10, sadece production’da kullanılır)

App Store/TestFlight publish (CI)
- Secrets required:
  - `IOS_CERT_P12_BASE64` Base64-encoded distribution certificate (.p12)
  - `IOS_CERT_PASSWORD` Certificate password
  - `IOS_PROVISIONING_PROFILE_BASE64` Base64-encoded provisioning profile (.mobileprovision)
  - `APP_STORE_CONNECT_API_KEY` ASC private key (content starting with `-----BEGIN PRIVATE KEY-----`)
  - `APP_STORE_CONNECT_API_KEY_ID` Key ID
  - `APP_STORE_CONNECT_ISSUER_ID` Issuer ID
- Varsayılan: TestFlight yükleme. Aşağıdaki env ile App Store review submission aktif edilebilir:
  - `IOS_SUBMIT_FOR_REVIEW=true|false` (default: false)
  - `IOS_AUTOMATIC_RELEASE=true|false` (default: false)
  - `TESTFLIGHT_GROUPS` (virgülle ayrılmış) verilirse TestFlight dış dağıtımı yapılır.

Locally building releases
- Android AAB: `flutter build appbundle -t lib/main_prod.dart --flavor prod --release`
- Android APK: `flutter build apk -t lib/main_prod.dart --flavor prod --release`
- iOS IPA (unsigned): `flutter build ipa -t lib/main_prod.dart --flavor prod --release --no-codesign`

## Environment (.env) with flavors

- Env files live under `assets/env/` and are bundled with the app:
  - `assets/env/.env` (fallback/default)
  - `assets/env/.env.dev`
  - `assets/env/.env.qa`
  - `assets/env/.env.prod`
- Keys:
  - `BASE_URL` string
  - `LOG_LEVEL` one of: `debug|info|warn|error`
  - Feature flags use `FEATURE_` prefix, e.g. `FEATURE_NEW_DASHBOARD=true`
  - Security (non-secret): `FORCE_HTTPS`, `TLS_PINNING_ENABLED`, `TLS_PIN_ASSETS`

How it works
- Each flavor entrypoint loads its env before DI:
  - `lib/main_dev.dart` → `.env.dev`
  - `lib/main_qa.dart` → `.env.qa`
  - `lib/main_prod.dart` → `.env.prod`
- Values are provided app-wide via `AppConfig` (GetX):

Usage example
```dart
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/config/app_config.dart';

final config = Get.find<AppConfig>();
final apiBase = config.baseUrl; // e.g., https://dev-api.example.com
final isNewDashboardOn = config.isFeatureEnabled('NEW_DASHBOARD');
```

Run commands
- Dev: `flutter run --flavor dev -t lib/main_dev.dart`
- QA: `flutter run --flavor qa -t lib/main_qa.dart`
- Prod: `flutter run --flavor prod -t lib/main_prod.dart`

## Security

- Do not store secrets in `.env` files; they are bundled with the app. Use them for non-sensitive config.
- Android: explicit Network Security Config in release (`android:usesCleartextTraffic=false`, `@xml/network_security_config`). Debug allows local/proxy use via `network_security_config_debug`.
- iOS: ATS explicitly disallows arbitrary loads. For domain exceptions, edit `ios/Runner/Info.plist`.
- Request layer: HTTPS enforcement and Authorization header injection added to example provider (GetConnect).

TLS pinning (optional)
- Place server certs under `assets/certs/` (PEM/DER). See `assets/certs/README.txt`.
- Enable in env (e.g. `.env.prod`):
  - `TLS_PINNING_ENABLED=true`
  - `TLS_PIN_ASSETS=assets/certs/api_prod.pem,assets/certs/api_backup.pem`
- The app installs a pinned SecurityContext globally when enabled (limits trust to provided certs).

## Versioning & Changelog

- Bump version and update CHANGELOG via:
  - Patch: `dart run tool/version_bump.dart patch -m "Fixes/changes here"`
  - Minor: `dart run tool/version_bump.dart minor -m "New features"`
  - Major: `dart run tool/version_bump.dart major -m "Breaking changes"`
- Commit, tag, and push:
  - `git add pubspec.yaml CHANGELOG.md`
  - `git commit -m "chore(release): vX.Y.Z"`
  - `git tag vX.Y.Z`
  - `git push && git push --tags`

## Icon & Splash configuration

- Place a 1024x1024 app icon at `assets/icons/app_icon.png`.
- Generate launcher icons: `flutter pub run flutter_launcher_icons`
- Generate native splash (currently color-only): `flutter pub run flutter_native_splash:create`

## Fastlane (optional/local)

Android
- Lanes in `android/fastlane/Fastfile`:
  - `internal` uploads AAB to Google Play internal track
  - `release` uploads to production
- Provide JSON key via env var `PLAY_SERVICE_ACCOUNT_JSON_PATH`.

iOS
- Lanes in `ios/fastlane/Fastfile`:
  - `beta` builds and uploads to TestFlight
  - `beta_ipa` uploads an existing IPA from `build/ios/ipa`
  - `release` builds and uploads to App Store (not auto-submit)
- Provide API key via env vars `APP_STORE_CONNECT_API_KEY_ID`, `APP_STORE_CONNECT_ISSUER_ID`, `APP_STORE_CONNECT_API_KEY`.
