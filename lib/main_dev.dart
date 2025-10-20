//Created by https://github.com/kaandinler

import 'package:getx_boilerplate/app/flavor/environment.dart';
import 'package:getx_boilerplate/app/flavor/flavor.dart';
import 'package:getx_boilerplate/main.dart';

void main() async {
  FlavorConfig(
    flavor: Environment.dev,
    name: "Development",
    env: Environment.dev.name,
    values: FlavorValues(
      bundleID: "com.example.getx_boilerplate",
      appName: "GetX Boilerplate",
    ),
  );

  await bootstrapApp(envFile: 'assets/env/.env.dev');
}
