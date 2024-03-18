import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/home/bindings/home_binding.dart';
import 'package:getx_boilerplate/app/modules/page/home/views/home_view.dart';
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
                Get.to(() => const HomeView(), binding: HomeBinding());
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
