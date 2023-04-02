import 'package:flutter/material.dart';

class AppIcons {
  // This is singleton it has only one instance throughout
  // our app and we can use it throughout our app
  AppIcons._();

  static const fontFam = 'AppIcons';
  static const IconData trophyOutline = IconData(0xe808, fontFamily: fontFam);
  static const IconData menuLeft = IconData(0xe805, fontFamily: fontFam);
  static const IconData peace = IconData(0xe806, fontFamily: fontFam);
  static const IconData menu = IconData(0xe804, fontFamily: fontFam);
}
