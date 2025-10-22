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
        title: Text('home.title'.tr),
        centerTitle: true,
      ),
      body: controller.obx(
        onLoading: const Center(child: CircularProgressIndicator()),
        onEmpty: Center(child: Text('common.no_data'.tr)),
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
            child: Text('buttons.save_local'.tr)),
        ElevatedButton(
            onPressed: () {
              controller.readDataFromLocalStorage();
            },
            child: Text('buttons.read_local'.tr)),
        ElevatedButton(
            onPressed: () {
              controller.saveDataToSecureStorage();
            },
            child: Text('buttons.save_secure'.tr)),
        ElevatedButton(
            onPressed: () {
              controller.readDataFromSecureStorage();
            },
            child: Text('buttons.read_secure'.tr)),
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('bottomsheet.reusable_title'.tr),
                SizedBox(height: 12),
                Text('bottomsheet.reusable_message'.tr),
              ],
            ),
          );
        },
        child: Text('buttons.show_bottom_sheet'.tr));
  }

  ElevatedButton _showConfirmBottomSheet() {
    return ElevatedButton(
      onPressed: () async {
        final sheet = Get.find<IBottomSheetService>();
        final result = await sheet.showConfirm(
          title: 'confirm.title'.tr,
          message: 'confirm.message'.tr,
          confirmText: 'common.yes'.tr,
          cancelText: 'common.no'.tr,
        );
        if (result != null) {
          Get.showSnackbar(
            GetSnackBar(
              message: 'confirm.result'.trParams({'result': result ? 'common.yes'.tr : 'common.no'.tr}),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Text('buttons.show_confirm_bottom_sheet'.tr),
    );
  }

  ElevatedButton _goMainPage() {
    return ElevatedButton(
      onPressed: () {
        Get.toNamed(Routes.MAIN);
      },
      child: Text('buttons.go_main'.tr),
    );
  }

  ElevatedButton _showDefaultDialog(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: true,
          builder: (ctx) => AlertDialog(
            title: Text('dialogs.title'.tr),
            content: Text('dialogs.message'.tr),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
                child: Text('common.cancel'.tr),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx, rootNavigator: true).pop(),
                child: Text('common.confirm'.tr),
              ),
            ],
          ),
        );
      },
      child: Text('buttons.show_dialog'.tr),
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
          GetSnackBar(
            title: 'dialogs.title'.tr,
            message: 'dialogs.message'.tr,
            duration: Duration(seconds: 3),
            snackPosition: SnackPosition.TOP,
          ),
        );
      },
      child: Text('buttons.show_snackbar'.tr),
    );
  }

  ElevatedButton _goSecondScreen() {
    return ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.THIRD, arguments: 'Data from ThirdView');
        },
        child: Text('buttons.go_third'.tr));
  }

  OverflowBar _goRoute() {
    return OverflowBar(
      alignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            Get.toNamed(Routes.UNKNOWN);
          },
          child: Text('buttons.unknown_page'.tr),
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
          child: Text('buttons.change_theme'.tr),
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
