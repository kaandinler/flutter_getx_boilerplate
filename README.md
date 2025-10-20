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
