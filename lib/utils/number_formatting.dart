import 'package:intl/intl.dart';

class NumberFormatting {
  static formatCurrency(int value) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    String formattedValue = formatter.format(value);
    return formattedValue;
  }
}
