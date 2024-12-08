import 'package:flutter/material.dart';

const String baseUrl = "https://gutendex.com/books/";
final Color? kMainColor = hexToColor("#fed6b6");

/// Construct a color from a hex code string, of the format #RRGGBB.
Color hexToColor(String code) {
  return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}
