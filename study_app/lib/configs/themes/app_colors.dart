import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_dark_theme.dart';
import 'package:study_app/configs/themes/app_light_theme.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';

const Color onSurfaceTextColor = Colors.white;

const MainGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryLightColorLight, primaryColorLight]);

const MainGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryDarkColorDark, primaryColorDark]);

LinearGradient mainGradient(BuildContext context) =>
    (UIParameters.isDarkMode(context)) ? MainGradientDark : MainGradientLight;

customScaffoldColor(BuildContext context) => (UIParameters.isDarkMode(context))
    ? const Color(0xFF2e3c62)
    : const Color.fromARGB(255, 250, 225, 251);
