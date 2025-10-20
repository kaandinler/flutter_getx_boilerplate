import 'package:flutter/widgets.dart';

abstract class IBottomSheetService {
  Future<T?> show<T>({
    required Widget child,
    bool isScrollControlled = false,
    bool enableDrag = true,
    bool isDismissible = true,
    Color? backgroundColor,
  });

  Future<bool?> showConfirm({
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    bool isDismissible = true,
  });
}
