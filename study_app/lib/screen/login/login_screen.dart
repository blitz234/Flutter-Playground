import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/widgets/common/main_button.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  static const String routename = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(gradient: mainGradient(context)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/app_splash_logo.png",
            width: 200,
            height: 200,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 60.0),
            child: Text(
              "This is a study app. You can use it however you want. You have full access to all the course contents.",
              style: TextStyle(
                color: onSurfaceTextColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          MainButton(
            onTap: (() {
              controller.signInWithGoogle();
            }),
            child: Stack(
              children: [
                Positioned(
                    left: 10,
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset("assets/icons/google.svg")),
                Center(
                  child: Text(
                    "Sign In to Google",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
