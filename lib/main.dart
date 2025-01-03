import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_equran/app.dart';
import 'package:my_equran/core/flavors.dart';
import 'package:my_equran/utils/fingerprint_auth.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FingerprintAuth.setMethodCallHandler();
  const String appFlavor = String.fromEnvironment('APP_FLAVOR', defaultValue: 'dev');
  await dotenv.load(fileName: ".env.$appFlavor");
  setFlavor(appFlavor);
  await di.init();
  runApp(MyApp());
}