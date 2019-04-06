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

  static BoxDecoration viewDecoration() => BoxDecoration(
    color: Colors.black45,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(16.0),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black12,
        blurRadius: 10.0,
        offset: Offset(0.0, 10.0),
      ),
    ],
  );

}