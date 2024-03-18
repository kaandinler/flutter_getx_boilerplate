import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin {
  //TODO: Implement HomeController

  final count = 0.obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    //change state from loading to success with using StateMixin
    Future.delayed(const Duration(milliseconds: 1500),
        () => change(null, status: RxStatus.success()));
  }

  void increment() => count.value++;
}
