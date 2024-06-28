import 'package:flutter/widgets.dart';

class ScreenSize {
  static late double _screenWidth;
  static late double _screenHeight;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
}
