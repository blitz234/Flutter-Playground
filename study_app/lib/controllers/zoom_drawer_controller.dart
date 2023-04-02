import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Rxn<User?> user = Rxn();

  @override
  void onReady() {
    user.value = Get.find<AuthController>().getUser();
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {
    Get.find<AuthController>().signOut();
    Get.offAllNamed('/home');
  }

  void signIn() {}

  void website() {}

  void email() {
    final Uri emailLaunchUri =
        Uri(scheme: 'mailto', path: 'katiyarankush07@gmail.com');

    launch(emailLaunchUri.toString());
  }

  launch(String url) async {
    if (!await launch(url)) {
      throw 'could not launch $url';
    }
  }
}
