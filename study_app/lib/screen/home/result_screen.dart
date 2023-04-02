import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';
import 'package:study_app/controllers/question_paper/questions_controller.dart';
import 'package:study_app/screen/check_answer_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/controllers/questions_controller_extension.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/question_number_card.dart';

class ResultScreen extends GetView<QuestionsController> {
  const ResultScreen({super.key});
  static const String routeName = "/resultscreen";
  @override
  Widget build(BuildContext context) {
    Color textColor =
        Get.isDarkMode ? Colors.white : Theme.of(context).primaryColor;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        leading: const SizedBox(
          height: 20,
        ),
        title: controller.correctAnsweredQuestions,
      ),
      body: BackGround(
          child: Column(
        children: [
          Expanded(
              child: ContentArea(
            addPadding: true,
            child: Column(children: [
              SvgPicture.asset('assets/images/bulb.svg'),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 8),
                child: Text(
                  "Congratulations",
                  style: headerText.copyWith(color: textColor),
                ),
              ),
              Text(
                "You have ${controller.totalScore} points",
                style: TextStyle(color: textColor),
              ),
              const SizedBox(
                height: 25,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Tap below questions numbers to view correct answers",
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: controller.allQuestions.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: Get.width ~/ 75,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder: ((context, index) {
                      final question = controller.allQuestions[index];
                      AnswerStatus status = AnswerStatus.notAnswered;
                      final selectedAnswer = question.selectedAnswer;
                      final correctAnswer = question.correctAnswer;

                      if (selectedAnswer == correctAnswer) {
                        status = AnswerStatus.correct;
                      } else {
                        status = AnswerStatus.wrong;
                      }

                      return QuestionNumberCard(
                        index: index + 1,
                        status: status,
                        onTap: () {
                          controller.jumpToQuestion(index, isGoBack: false);
                          Get.toNamed(AnswerCheckScreen.routeName);
                        },
                      );
                    })),
              ),
              ColoredBox(
                color: customScaffoldColor(context),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: MainButton(
                          onTap: () {
                            controller.tryAgain();
                          },
                          child: null,
                          color: notAnswerColor.withOpacity(0.1),
                          title: 'Try Again',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: MainButton(
                          onTap: (() {
                            controller.saveTestResults();
                          }),
                          title: 'Go Home',
                          child: null,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ]),
          ))
        ],
      )),
    );
  }
}
