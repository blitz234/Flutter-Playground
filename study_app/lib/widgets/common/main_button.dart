import 'package:flutter/material.dart';
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
      child: SizedBox(
        height: 55,
        width: double.maxFinite,
        child: InkWell(
          onTap: enabled ? onTap : null,
          child: child ??
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: onSurfaceTextColor),
              ),
        ),
      ),
    );
  }
}
