import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';

class MyZoomDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  @override
  void onReady() {
    super.onReady();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void signOut() {}

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
