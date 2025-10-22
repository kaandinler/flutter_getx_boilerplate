import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'api_error.dart';

class ConnectivityService extends GetxService {
  final _isOnline = true.obs;
  late final StreamSubscription _sub;

  bool get isOnline => _isOnline.value;

  Future<ConnectivityService> init() async {
    final conn = await Connectivity().checkConnectivity();
    _isOnline.value = conn != ConnectivityResult.none;
    _sub = Connectivity().onConnectivityChanged.listen((result) {
      _isOnline.value = result != ConnectivityResult.none;
    });
    return this;
  }

  Future<void> ensureConnected() async {
    if (!isOnline) throw NoConnectionException();
  }

  @override
  void onClose() {
    _sub.cancel();
    super.onClose();
  }
}

