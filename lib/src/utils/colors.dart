import 'dart:ui';
import 'package:flutter/material.dart';

class Utils {
  static const regular_size = 9.0;
  static const header_size = 22.0;
  static const sub_header_size = 14.0;
  static const ticket_size = 16.0;
  static const info_size = 18.0;
  static const regular_weight = FontWeight.w400;
  static const header_weight = FontWeight.w600;


  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static TextStyle getPreparedTextStyle({String fontFamily, Color color, double fontSize, FontWeight fontWeight}) => TextStyle(
      fontFamily: fontFamily ?? 'GoogleSans',
      color: color ?? Colors.white,
      fontSize: fontSize ?? regular_size,
      fontWeight: fontWeight ?? regular_weight);

  static Color getCommunityColor(String type) {
    if (type == "gdg") {
      return Colors.blue;
    } else if (type == "gde") {
      return Colors.indigo;
    } else {
      return Colors.greenAccent;
    }
  }

  static String getSessionImageAsset(String tag) {
    if (tag == 'Machine Learning') return 'assets/tags/machine_learning.jpg';
    if (tag == 'Kotlin') return 'assets/tags/kotlin.png';
    if (tag == 'Android') return 'assets/tags/android.jpg';
    return 'assets/images/logo.png';
  }
}
