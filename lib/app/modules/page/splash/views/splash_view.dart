import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.flutter_dash,
              size: 150,
              color: Colors.blue,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
