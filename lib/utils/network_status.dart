import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
abstract class NetworkInfo{
  Future<bool> isConnected();
}

class NetworkStatus implements NetworkInfo{
  static const _platform = MethodChannel('com.equran.app/native');

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

//1. play audio per surat
//2. tambahkan auto play per ayat
//3. slide audio per surah
//4. fingerprint untuk ke halaman utama -> native
