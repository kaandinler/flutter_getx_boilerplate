import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/home/controllers/home_controller.dart';
import 'package:getx_boilerplate/infrastructure/navigation/navigation.dart';
import 'package:getx_boilerplate/presentation/second/second.screen.dart';

//Created by https://github.com/kaandinler

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return EnvironmentsBadge(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeView AppBar'),
          centerTitle: true,
        ),
        body: controller.obx(
          onLoading: const Center(child: CircularProgressIndicator()),
          onEmpty: const Center(child: Text('Not data found')),
          onError: (error) => Center(child: Text('Error: $error')),
          (state) => Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _helloWorldLocale(),
              _helloNameLocale(),
              _changeLocale(),
              _changeTheme(),
              _goRoute(),
              _goSecondScreen(),
              _goMainPage(),
              _dialogButtons()
            ],
          ),
        ),
      ),
    );
  }

  ButtonBar _dialogButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        _showSnackBar(),
        _showDefaultDialog(),
        _showBottomSheet(),
      ],
    );
  }

  ElevatedButton _showBottomSheet() {
    return ElevatedButton(
        onPressed: () {
          Get.bottomSheet(
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: const Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('BottomSheet'),
                ],
              ),
            ),
          );
        },
        child: const Text('Show BottomSheet'));
  }

  ElevatedButton _goMainPage() {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed('/main');
      },
      child: const Text('Go to Main Page'),
    );
  }

  ElevatedButton _showDefaultDialog() {
    return ElevatedButton(
        onPressed: () {
          Get.defaultDialog(
            title: 'Dialog Title',
            middleText: 'This is middle text',
            textConfirm: 'Confirm',
            textCancel: 'Cancel',
            onConfirm: () {},
            onCancel: () {},
          );
        },
        child: const Text('Show Dialog'));
  }

  ElevatedButton _showSnackBar() {
    return ElevatedButton(
        onPressed: () {
          Get.snackbar('Title', 'Message');
        },
        child: const Text('Show SnackBar'));
  }

  ElevatedButton _goSecondScreen() {
    return ElevatedButton(
        onPressed: () {
          Get.to(const SecondScreen(), arguments: 'Data from First');
        },
        child: const Text('Go to Second Screen'));
  }

  ButtonBar _goRoute() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/unknown');
          },
          child: const Text('Unknown Page'),
        ),
      ],
    );
  }

  ButtonBar _changeTheme() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.changeTheme(Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
          },
          child: const Text('Change Theme'),
        ),
      ],
    );
  }

  ButtonBar _changeLocale() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.updateLocale(const Locale('en', 'US'));
          },
          child: const Text('English'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.updateLocale(const Locale('de', 'DE'));
          },
          child: const Text('Deutsch'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.updateLocale(const Locale('tr', 'TR'));
          },
          child: const Text('Türkçe'),
        ),
      ],
    );
  }

  Center _helloNameLocale() {
    return Center(
      child: Text(
        'hello_name'.trParams({'name': 'Kaan'}),
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }

  Center _helloWorldLocale() {
    return Center(
      child: Text(
        'hello'.tr,
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
