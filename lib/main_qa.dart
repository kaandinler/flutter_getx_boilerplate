//Created by https://github.com/kaandinler

import 'package:getx_boilerplate/app/flavor/environment.dart';
import 'package:getx_boilerplate/app/flavor/flavor.dart';
import 'package:getx_boilerplate/main.dart';

void main() {
  FlavorConfig(
    flavor: Environment.qa,
    name: "QA",
    env: Environment.qa.name,
    values: FlavorValues(
      bundleID: "com.example.getx_boilerplate",
      appName: "GetX Boilerplate",
    ),
  );

  mainCommon();
}
