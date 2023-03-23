import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/app_icons.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/controllers/zoom_drawer_controller.dart';
import 'package:study_app/screen/home/menu_screen.dart';
import 'package:study_app/screen/home/quesiton_card.dart';
import 'package:study_app/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // instance of question paper controller that loads all the data for quizzes
    QuestionPaperController questionPaperController = Get.find();
    // Ui starts here
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(gradient: mainGradient(context)),
      child: GetBuilder<MyZoomDrawerController>(
        builder: ((_) {
          return ZoomDrawer(
            borderRadius: 50.0,
            controller: _.zoomDrawerController,
            mainScreenTapClose: true,
            angle: 0.0,
            menuBackgroundColor: Colors.transparent,
            style: DrawerStyle.defaultStyle,
            slideWidth: MediaQuery.of(context).size.width * 0.7,
            menuScreen: const MenuScreen(),
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient(context)),
              child: SafeArea(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(mobileScreenPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: const Icon(AppIcons.menuLeft),
                              onTap: () {
                                controller.toggleDrawer();
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Icon(
                                    AppIcons.peace,
                                  ),
                                  Text(
                                    "Hello Friend",
                                    style: detailText.copyWith(
                                        color: onSurfaceTextColor),
                                  )
                                ],
                              ),
                            ),
                            const Text(
                              "What do you want to learn today?",
                              style: headerText,
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          child: Obx(() => ListView.separated(
                              padding: UIParameters.mobileScreenPadding,
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return QuestionCard(
                                  model:
                                      questionPaperController.allPaper[index],
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return const SizedBox(
                                  height: 20,
                                );
                              }),
                              itemCount:
                                  questionPaperController.allPaper.length)),
                        ),
                      ))
                    ]),
              ),
            ),
          );
        }),
      ),
    ));
  }
}
