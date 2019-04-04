import 'dart:ui';

import 'package:flutter/material.dart';

class Utils {
  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static TextStyle baseTextStyle() => TextStyle(
    fontFamily: 'GoogleSans',
  );

  static TextStyle regularTextStyle() => TextStyle(
      fontFamily: 'GoogleSans',
      color: Colors.white, fontSize: 9.0, fontWeight: FontWeight.w400);

  static TextStyle subHeaderTextStyle() => TextStyle(
      fontFamily: 'GoogleSans',
      color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w400);

  static TextStyle subHeaderTextStyle2() => TextStyle(
      fontFamily: 'GoogleSans',
      color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600);

  static TextStyle headerTextStyle(Color color) => TextStyle(
      fontFamily: 'GoogleSans',
      color: color, fontSize: 22.0, fontWeight: FontWeight.w600);

}