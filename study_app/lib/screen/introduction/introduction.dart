import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/widgets/app_circle_button.dart';
import 'package:get/get.dart';

class Introduction extends StatelessWidget {
  const Introduction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: mainGradient(context),
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  size: 65,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Prepare Quizzes, for your subjects. Make learning fun with this creative Quiz App.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppCircleButton(
                  onTap: (() => Get.offAndToNamed('/home')),
                  child: const Icon(Icons.arrow_forward, size: 35),
                )
              ],
            ),
          )),
    );
  }
}
