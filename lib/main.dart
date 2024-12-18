import 'package:flutter/material.dart';
import 'package:my_equran/app.dart';
import 'package:my_equran/core/flavors.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const String appFlavor = String.fromEnvironment('APP_FLAVOR', defaultValue: 'dev');
  setFlavor(appFlavor);
  await di.init();
  runApp(MyApp());
}