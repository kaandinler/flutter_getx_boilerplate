//Created by https://github.com/kaandinler

import 'package:getx_boilerplate/app/flavor/environment.dart';

class FlavorValues {
  final String? bundleID;
  final String? appName;

  FlavorValues({this.bundleID, this.appName});
}

class FlavorConfig {
  final Environment flavor;
  final String env;
  final String name;
  final FlavorValues? values;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Environment flavor,
    required String name,
    required String env,
    required FlavorValues values,
  }) {
    _instance ??= FlavorConfig._internal(
      flavor,
      name,
      env,
      values,
    );

    return _instance!;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
    this.env,
    this.values,
  );

  static FlavorConfig get instance {
    return _instance!;
  }

  static bool isProduction() => _instance!.flavor == Environment.prod;

  static bool isDevelopment() => _instance!.flavor == Environment.dev;

  static bool isQA() => _instance!.flavor == Environment.qa;
}
