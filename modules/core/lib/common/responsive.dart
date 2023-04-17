import 'package:flutter/material.dart';

class AppResponsive {
  static late MediaQueryData _mediaQueryData;

  static MediaQueryData get mediaQueryData => _mediaQueryData;

  static void init({required BuildContext context}) {
    _mediaQueryData = MediaQuery.of(context);
  }


  static double percentWidth(double num) {
    return num/100 * _mediaQueryData.size.width;
  }

  static double percentHeight(double num) {
    return num/100 * _mediaQueryData.size.height;
  }
}

extension SizeExtension on num {
  double get w => AppResponsive.percentWidth(toDouble());

  double get h => AppResponsive.percentHeight(toDouble());
}