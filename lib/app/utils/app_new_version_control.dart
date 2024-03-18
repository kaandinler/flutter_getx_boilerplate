import 'package:get/get.dart';
import 'package:getx_boilerplate/app/utils/flavor.dart';
import 'package:new_version_plus/new_version_plus.dart';

class AppNewVersionControl {
  static Future<void> checkAppVersion() async {
    final newVersion = NewVersionPlus(
      iOSId: FlavorConfig.instance.values?.bundleID,
      androidId: FlavorConfig.instance.values?.bundleID,
    );

    final status = await newVersion.getVersionStatus();
    if (status != null && status.canUpdate) {
      newVersion.showUpdateDialog(
        context: Get.context!,
        versionStatus: status,
        dialogTitle: 'Update Available',
        dialogText: 'A new version of the app is available!',
        updateButtonText: 'Update',
        dismissButtonText: 'Later',
        dismissAction: () {
          //INFO - Do something when the user dismisses the dialog - e.g. ask again later
        },
      );
    }
  }
}
