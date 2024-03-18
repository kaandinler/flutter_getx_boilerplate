//Created by https://github.com/kaandinler

enum Flavor { dev, qa, prod }

class FlavorValues {
  final String? bundleID;
  final String? appName;

  FlavorValues({this.bundleID, this.appName});
}

class FlavorConfig {
  final Flavor flavor;
  final String env;
  final String name;
  final FlavorValues? values;
  static FlavorConfig? _instance;

  factory FlavorConfig({
    required Flavor flavor,
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

  static bool isProduction() => _instance!.flavor == Flavor.prod;

  static bool isDevelopment() => _instance!.flavor == Flavor.dev;

  static bool isQA() => _instance!.flavor == Flavor.qa;
}
