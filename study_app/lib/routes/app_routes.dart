import 'package:get/get.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/screen/home/home_screen.dart';
import 'package:study_app/screen/introduction/introduction.dart';
import 'package:study_app/screen/login/login_screen.dart';
import 'package:study_app/services/firebase_storage_service.dart';
import '../screen/splash/splash_screen.dart';

// routes for the app declared for getPages in main.dart
class AppRoutes {
  // getpage is the way to declare name routes in get navigation
  static List<GetPage> routes() => [
        GetPage(name: "/", page: (() => const SplashScreen())),
        GetPage(name: "/intro", page: (() => const Introduction())),
        GetPage(
          name: '/home',
          page: () => const HomeScreen(),
          binding: BindingsBuilder((() {
            Get.put(QuestionPaperController());
            Get.put(MyZoomDrawerController());
          })),
        ),
        GetPage(name: LoginScreen.routename, page: (() => const LoginScreen()))
      ];
}
