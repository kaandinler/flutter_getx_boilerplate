//Created by https://github.com/kaandinler

import 'package:getx_boilerplate/app/utils/flavor.dart';
import 'package:getx_boilerplate/main.dart';

void main() {
  FlavorConfig(
    flavor: Flavor.dev,
    name: "Development",
    env: "dev",
    values: FlavorValues(
      bundleID: "com.example.getx_boilerplate",
      appName: "GetX Boilerplate",
    ),
  );

  mainCommon();
}
