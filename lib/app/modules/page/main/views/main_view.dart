import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:getx_boilerplate/app/modules/page/home/views/home_view.dart';
import 'package:getx_boilerplate/app/modules/page/main/controllers/main_controller.dart';
import 'package:getx_boilerplate/app/modules/page/unknown/views/unknown_view.dart';
import 'package:getx_boilerplate/presentation/second/second.screen.dart';

//Created by https://github.com/kaandinler

class MainView extends GetView<MainController> {
  const MainView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MainView'),
          centerTitle: true,
        ),
        bottomNavigationBar: Obx(() {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
            ],
            currentIndex: controller.activeTab.value,
            selectedItemColor: Colors.amber[800],
            onTap: (index) {
              controller.changeIndex(index);
            },
          );
        }),
        body: Obx(() {
          return IndexedStack(
            index: controller.activeTab.value,
            children: const <Widget>[
              HomeView(),
              UnknownView(),
              SecondScreen(),
              // Center(
              //   child: Text('Home'),
              // ),
              // Center(
              //   child: Text('Business'),
              // ),
              // Center(
              //   child: Text('School'),
              // ),
            ],
          );
        }));
  }
}
