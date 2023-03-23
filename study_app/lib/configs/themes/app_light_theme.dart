import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/subtheme_data_mixin.dart';

const Color primaryLightColorLight = Color(0xFF3ac3cb);
const Color primaryColorLight = Color(0xfff85187);
const Color mainTextColor = Color.fromARGB(255, 40, 40, 40);
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class LightTheme with SubThemeData {
  buildLightTheme() {
    final ThemeData systemLightTheme = ThemeData.light();
    return systemLightTheme.copyWith(
        primaryColor: primaryColorLight,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardColor: cardColor,
        iconTheme: getIconTheme(),
        textTheme: getTextThemes().apply(
          bodyColor: mainTextColor,
          displayColor: mainTextColor,
        ));
  }
}
