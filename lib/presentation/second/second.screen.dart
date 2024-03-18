import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/modules/page/third/views/third_view.dart';
import 'package:getx_boilerplate/infrastructure/navigation/navigation.dart';
import 'package:getx_boilerplate/presentation/second/controllers/second.controller.dart';

class SecondScreen extends GetView<SecondController> {
  const SecondScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return EnvironmentsBadge(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SecondScreen'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                'SecondScreen is working',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Text('Data from First: ${Get.arguments}'),
            ElevatedButton(
                onPressed: () {
                  Get.off(() => const ThirdView());
                },
                child: const Text('Go to Third Page and Remove this Screen from Stack')),
            ElevatedButton(
                onPressed: () {
                  Get.offAll(() => const ThirdView());
                },
                child: const Text('Go to Third Page and Remove Everything from Stack')),
            ElevatedButton(
                onPressed: () async {
                  var dataFromThird = await Get.to(() => const ThirdView());
                  // var dataFromThird = await Get.to(() => const ThirdView());
                  print(dataFromThird);
                },
                child: const Text('Get Data From Third Page')),
          ],
        ),
      ),
    );
  }
}
