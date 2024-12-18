import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
abstract class NetworkInfo{
  Future<bool> isConnected();
}

class NetworkStatus implements NetworkInfo{
  static const _platform = MethodChannel('network-status');

  static Future<bool> isNetworkOnline() async {
    try {
      final bool status = await _platform.invokeMethod('isNetworkOnline');
      return status;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print("Failed to get network status: ${e.message}");
      }
      return false;
    }
  }

  @override
  Future<bool> isConnected() {
    return NetworkStatus.isNetworkOnline();
  }
}
