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