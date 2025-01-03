import 'package:flutter/services.dart';

class FingerprintAuth {
  static const MethodChannel _channel = MethodChannel('com.equran.app/native');

  static Future<bool> authenticate() async {
    try {
      // Setting the method call handler before invoking the method
      bool isAuthenticated = await _channel.invokeMethod('fingerprint-auth');

      // Handle the result based on success or failure
      return isAuthenticated;
    } on PlatformException catch (e) {
      print("Authentication failed: ${e.message}");
      return false;  // Return false if there was an error
    }
  }
  static void setMethodCallHandler() {
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'authenticationResult') {
        bool result = call.arguments ?? false;
        return result; // Returning the result to indicate success/failure
      }
    });
  }
}
