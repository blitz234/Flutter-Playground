import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(gradient: mainGradient(context)),
      child: Center(
        child: SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("assets/images/app_splash_logo.png")),
      ),
    ));
  }
}
