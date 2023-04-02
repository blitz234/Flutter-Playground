import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';
import 'package:study_app/controllers/question_paper/questions_controller.dart';
import 'package:study_app/screen/home/quesiton_card.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/countdown_timer.dart';
import 'package:study_app/widgets/questions/answer_card.dart';
import 'package:study_app/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});
  static const String routeName = "/testOverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: controller.completedTest,
        ),
        body: BackGround(
          child: Column(
            children: [
              Expanded(
                  child: ContentArea(
                      addPadding: true,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CountdownTimer(
                                  time: '',
                                  color: UIParameters.isDarkMode(context)
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color
                                      : Theme.of(context).primaryColor),
                              Obx((() => Text(
                                    "${controller.time.value} remaining",
                                    style: countDownTimerTS(context),
                                  )))
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: GridView.builder(
                                itemCount: controller.allQuestions.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: Get.width ~/ 75,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: ((context, index) {
                                  AnswerStatus? _answerStatus;
                                  if (controller
                                          .allQuestions[index].selectedAnswer !=
                                      null) {
                                    _answerStatus = AnswerStatus.answered;
                                  }
                                  return QuestionNumberCard(
                                    index: index + 1,
                                    status: _answerStatus,
                                    onTap: () {
                                      controller.jumpToQuestion(index);
                                    },
                                  );
                                })),
                          )
                        ],
                      ))),
              ColoredBox(
                color: customScaffoldColor(context),
                child: Padding(
                  padding: UIParameters.mobileScreenPadding,
                  child: MainButton(
                    onTap: () {
                      controller.complete();
                    },
                    title: "Complete",
                    child: null,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
