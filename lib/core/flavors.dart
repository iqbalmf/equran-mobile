import 'package:my_equran/core/app_config.dart';

enum Flavor {
  prod,
  dev;

  bool get isProduction => this == Flavor.prod;

  bool get isDevelopment => this == Flavor.dev;
}

class FlavorValues {
  final String title;
  final String baseUrl;
  final Flavor flavor;

  FlavorValues({
    required this.title,
    required this.baseUrl,
    required this.flavor,
  });
}

Flavor? _currentFlavor;

void setFlavor(String? appFlavor) {
  switch (appFlavor) {
    case 'prod':
      _currentFlavor = Flavor.prod;
      break;
    case 'dev':
    default:
      _currentFlavor = Flavor.dev;
      break;
  }
}

FlavorValues get flavorValues {
  switch (_currentFlavor) {
    case Flavor.prod:
      return FlavorValues(
        title: 'Movie List',
        baseUrl: ConstantsApp.baseUrl,
        flavor: _currentFlavor!,
      );
    case Flavor.dev:
    default:
      return FlavorValues(
        title: 'Movie List Dev',
        baseUrl: ConstantsApp.baseUrl,
        flavor: _currentFlavor ?? Flavor.dev,
      );
  }
}
