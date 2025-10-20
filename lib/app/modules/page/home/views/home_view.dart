import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:getx_boilerplate/app/routes/app_pages.dart';
import 'package:getx_boilerplate/app/shared/widgets/app_error_view.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_bottom_sheet_service.dart';

import 'package:getx_boilerplate/app/modules/page/home/controllers/home_controller.dart';

//Created by https://github.com/kaandinler

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView AppBar'),
        centerTitle: true,
      ),
      body: controller.obx(
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: const Center(child: Text('No data found')),
        onError: (error) => AppErrorView(
          title: 'Bir şeyler ters gitti',
          message: error ?? 'Beklenmeyen bir hata oluştu.',
          onRetry: () => controller.refresh(),
        ),
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
            _dialogButtons(context),
            _saveDataButtons(),
          ],
        ),
      ),
    );
  }

  ButtonBar _saveDataButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              controller.saveDataToLocalStorage();
            },
            child: const Text('Save Data to Local Storage')),
        ElevatedButton(
            onPressed: () {
              controller.readDataFromLocalStorage();
            },
            child: const Text('Read Data from Local Storage')),
        ElevatedButton(
            onPressed: () {
              controller.saveDataToSecureStorage();
            },
            child: const Text('Save Data to Secure Storage')),
        ElevatedButton(
            onPressed: () {
              controller.readDataFromSecureStorage();
            },
            child: const Text('Read Data from Secure Storage')),
      ],
    );
  }

  ButtonBar _dialogButtons(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        _showSnackBar(),
        _showDefaultDialog(context),
        _showBottomSheet(),
        _showConfirmBottomSheet(),
      ],
    );
  }

  ElevatedButton _showBottomSheet() {
    return ElevatedButton(
        onPressed: () {
          final sheet = Get.find<IBottomSheetService>();
          sheet.show(
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Reusable BottomSheet'),
                SizedBox(height: 12),
                Text('Bu icerik her yerde kolayca kullanilabilir.'),
              ],
            ),
          );
        },
        child: const Text('Show BottomSheet'));
  }

  ElevatedButton _showConfirmBottomSheet() {
    return ElevatedButton(
      onPressed: () async {
        final sheet = Get.find<IBottomSheetService>();
        final result = await sheet.showConfirm(
          title: 'Islemi onayla',
          message: 'Devam etmek istiyor musun?',
          confirmText: 'Evet',
          cancelText: 'Hayir',
        );
        if (result != null) {
          Get.showSnackbar(
            GetSnackBar(
              message: 'Sonuc: ${result ? 'Evet' : 'Hayir'}',
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: const Text('Show Confirm BottomSheet'),
    );
  }

  ElevatedButton _goMainPage() {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(Routes.MAIN);
      },
      child: const Text('Go to Main Page'),
    );
  }

  ElevatedButton _showDefaultDialog(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (ctx) => AlertDialog(
            title: const Text('Dialog Title'),
            content: const Text('This is middle text'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
                child: const Text('Confirm'),
              ),
            ],
          ),
        );
      },
      child: const Text('Show Dialog'),
    );
  }

  ElevatedButton _showSnackBar() {
    return ElevatedButton(
      onPressed: () {
        if (Get.overlayContext == null) {
          Get.log('Snackbar skipped (overlay not ready)');
          return;
        }
        Get.showSnackbar(
          const GetSnackBar(
            title: 'Title',
            message: 'Message',
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );
      },
      child: const Text('Show SnackBar'),
    );
  }

  ElevatedButton _goSecondScreen() {
    return ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.THIRD, arguments: 'Data from ThirdView');
        },
        child: const Text('Go to Third View'));
  }

  OverflowBar _goRoute() {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.UNKNOWN);
          },
          child: const Text('Unknown Page'),
        ),
      ],
    );
  }

  OverflowBar _changeTheme() {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            controller.changeThemeMode();
          },
          child: const Text('Change Theme'),
        ),
      ],
    );
  }

  OverflowBar _changeLocale() {
    return OverflowBar(
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
