//Created by https://github.com/kaandinler

import 'package:getx_boilerplate/app/flavor/environment.dart';
import 'package:getx_boilerplate/app/flavor/flavor.dart';
import 'package:getx_boilerplate/main.dart';

void main() async {
  FlavorConfig(
    flavor: Environment.qa,
    name: "QA",
    env: Environment.qa.name,
    values: FlavorValues(
      bundleID: "com.qandq.getx_boilerplate.qa",
      appName: "GetX Boilerplate",
    ),
  );

  await bootstrapApp(envFile: 'assets/env/.env.qa');
}
