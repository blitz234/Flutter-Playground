import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_dark_theme.dart';
import 'package:study_app/configs/themes/app_light_theme.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';

const Color onSurfaceTextColor = Colors.white;
const Color correctAnswerColor = Color(0xff3ac3cb);
const Color wrongAnswerColor = Color(0xfff85187);
const Color notAnswerColor = Color(0xff2a3c65);

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

Color answerSelectedColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? Theme.of(context).cardColor.withOpacity(0.5)
        : Theme.of(context).primaryColor;

Color answerBorderColor(BuildContext context) =>
    UIParameters.isDarkMode(context)
        ? const Color.fromARGB(255, 20, 46, 158)
        : const Color.fromARGB(255, 221, 221, 221);
