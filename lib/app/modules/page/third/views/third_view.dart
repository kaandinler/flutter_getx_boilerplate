import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_boilerplate/app/routes/app_pages.dart';
import 'package:getx_boilerplate/app/modules/page/third/controllers/third_controller.dart';

class ThirdView extends GetView<ThirdController> {
  const ThirdView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirdView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.HOME);
              },
              child: const Text(
                'Go to Home Page',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Get.back(
                  result: 'Data from Thirddddd',
                );
              },
              child: const Text(
                'Go to Second Screen',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
