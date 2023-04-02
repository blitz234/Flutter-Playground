import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      this.title = '',
      required this.onTap,
      this.enabled = true,
      required this.child,
      this.color});

  final String title;
  final VoidCallback onTap;
  final enabled;
  final Widget? child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16),
      color: color,
      child: SizedBox(
        height: 55,
        width: double.maxFinite,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: Center(
            child: child ??
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.isDarkMode
                          ? onSurfaceTextColor
                          : Theme.of(context).primaryColor),
                ),
          ),
        ),
      ),
    );
  }
}
