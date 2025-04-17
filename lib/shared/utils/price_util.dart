import 'package:intl/intl.dart';

String formatIranRial(double price) {
  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '',
    locale: 'en_US',
  );
  return formatCurrency.format(price).replaceAll(',', ',');
}