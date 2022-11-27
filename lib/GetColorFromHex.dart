import 'dart:ui';

import 'package:flutter/foundation.dart';

Color GetColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF$hexColor";
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  } else {
    if (kDebugMode) {
      print("Error with color");
    }
    return const Color(0xffbfeb91);
  }
}