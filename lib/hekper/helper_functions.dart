import 'dart:convert';
import 'dart:ffi';

import 'package:intl/intl.dart';

// Convert String to Double.
double convertStringToDouble(String text) {
  double? resultado = double.tryParse(text);
  return resultado ?? 0;
}

// Agrega formato correcto a valores de monto.
String formatMonto(double monto) {
  final result =
      NumberFormat.currency(locale: "en_US", symbol: "\$", decimalDigits: 2);
  return result.format(monto);
}
