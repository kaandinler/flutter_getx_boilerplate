import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/utils/flavor.dart';

import 'package:getx_boilerplate/presentation/screens.dart';
import 'package:getx_boilerplate/infrastructure/navigation/bindings/controllers/controllers_bindings.dart';
import 'package:getx_boilerplate/infrastructure/navigation/routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    var env = FlavorConfig.instance.env;
    // var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Flavor.prod.name
        ? Banner(
            location: BannerLocation.topEnd,
            message: env.capitalize ?? '',
            color: env == Flavor.qa.name ? Colors.blue : Colors.red,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SECOND,
      page: () => const SecondScreen(),
      binding: SecondControllerBinding(),
    ),
  ];
}
