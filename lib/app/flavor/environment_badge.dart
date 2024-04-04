import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/flavor/environment.dart';
import 'package:getx_boilerplate/app/flavor/flavor.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;
  const EnvironmentsBadge({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    var env = FlavorConfig.instance.env;
    return env != Environment.prod.name
        ? Banner(
            location: BannerLocation.topEnd,
            message: env.capitalize ?? '',
            color: env == Environment.qa.name ? Colors.blue : Colors.red,
            child: child,
          )
        : SafeArea(child: child); //SafeArea could be SizedBox.
  }
}
