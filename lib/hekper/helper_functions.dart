import 'dart:convert';
import 'dart:ffi';

double convertStringToDouble(String text) {
  double? resultado = double.tryParse(text);
  return resultado ?? 0;
}
