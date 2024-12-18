import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentApp {
  dev,
  prod;

  bool get isProduction => this == EnvironmentApp.prod;
  bool get isDevelopment => this == EnvironmentApp.dev;
}

class ConstantsApp {
  static const String getSurah = "/surat/";
  static const String getTafsir = "/tafsir/";
  static const String contentType = "application/json";
  static String baseUrl = "https://equran.id/api/v2";
}
