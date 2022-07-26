import 'package:flutter/material.dart';

class AppConstants {
  static const int splashDelay = 2;
  static const int sliderAnimationTime = 300;
}

class ConstantData {
  static Color primaryColor(context) => Theme.of(context).primaryColor;
  static Color mainTextColor(context) => Theme.of(context).primaryColorDark;
  static Color accentColor(context) => Theme.of(context).colorScheme.secondary;
  static Color bgColor(context) => Theme.of(context).scaffoldBackgroundColor;
}
