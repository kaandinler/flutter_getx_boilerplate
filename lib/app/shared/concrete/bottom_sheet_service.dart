import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_boilerplate/app/shared/abstract/i_bottom_sheet_service.dart';
import 'package:getx_boilerplate/app/shared/widgets/app_bottom_sheet.dart';

class BottomSheetService extends GetxService implements IBottomSheetService {
  @override
  Future<T?> show<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool enableDrag = true,
    bool isDismissible = true,
    Color? backgroundColor,
  }) async {
    return Get.bottomSheet<T>(
      AppBottomSheet(
        backgroundColor: backgroundColor,
        child: child,
      ),
      isScrollControlled: isScrollControlled,
      enableDrag: enableDrag,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Future<bool?> showConfirm({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDismissible = true,
  }) async {
    return show<bool?>(
      isDismissible: isDismissible,
      child: _ConfirmSheet(
        title: title,
        message: message,
        confirmText: confirmText,
        cancelText: cancelText,
      ),
    );
  }
}

class _ConfirmSheet extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const _ConfirmSheet({
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(message, style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Get.back(result: false),
                child: Text(cancelText),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Get.back(result: true),
                child: Text(confirmText),
              ),
            ),
          ],
        )
      ],
    );
  }
}
