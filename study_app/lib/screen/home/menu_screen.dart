import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';

class MenuScreen extends GetView<MyZoomDrawerController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Theme(
          data: ThemeData(
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                      foregroundColor: onSurfaceTextColor))),
          child: SafeArea(
            child: Stack(children: [
              Positioned(
                  child: Padding(
                padding: EdgeInsets.only(left: Get.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => (controller.user.value == null)
                        ? SizedBox()
                        : Text(
                            controller.user.value!.displayName ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: onSurfaceTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          )),
                    const Spacer(
                      flex: 1,
                    ),
                    DrawerButton(
                        onPressed: () {},
                        icon: Icons.facebook,
                        label: 'Facebook'),
                    const Spacer(
                      flex: 4,
                    ),
                    DrawerButton(
                        onPressed: (() {
                          controller.signOut();
                        }),
                        icon: Icons.logout,
                        label: 'LogOut')
                  ],
                ),
              ))
            ]),
          )),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.label});
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
        onPressed: onPressed, icon: Icon(icon, size: 15), label: Text(label));
  }
}
