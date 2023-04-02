import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/common/main_button.dart';
import 'package:study_app/widgets/common/question_place_holder.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/countdown_timer.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

import '../../controllers/question_paper/questions_controller.dart';

class QuestionScreen extends GetView<QuestionsController> {
  const QuestionScreen({super.key});
  static const String routeName = '/questionscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: onSurfaceTextColor, width: 2))),
            child: Obx((() => CountdownTimer(
                  time: controller.time.value,
                  color: onSurfaceTextColor,
                ))),
          ),
          showActionIcon: true,
          titleWidget: Obx((() => Text(
                "Q ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
                style: appBarTS,
              ))),
        ),
        body: BackGround(
            child: Obx(() => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (controller.loadingStatus.value ==
                          LoadingStatus.loading)
                        const Expanded(
                          child: ContentArea(child: QuestionScreenHolder()),
                        ),
                      if (controller.loadingStatus.value ==
                          LoadingStatus.completed)
                        Expanded(
                            child: ContentArea(
                          addPadding: true,
                          child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.only(top: 0),
                              child: Column(
                                children: [
                                  Text(
                                    controller
                                            .currentQuestion.value?.question ??
                                        '',
                                    style: questionTS,
                                  ),
                                  GetBuilder<QuestionsController>(
                                      id: 'answers_list',
                                      builder: (controller) {
                                        debugPrint("Get Builder called");
                                        return ListView.separated(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            padding:
                                                const EdgeInsets.only(top: 25),
                                            itemBuilder: ((context, index) {
                                              final answer = controller
                                                  .currentQuestion
                                                  .value!
                                                  .answers![index];

                                              return AnswerCard(
                                                  answer:
                                                      '${answer.identifier}. ${answer.answer}',
                                                  isSelected:
                                                      answer.identifier ==
                                                          controller
                                                              .currentQuestion
                                                              .value!
                                                              .selectedAnswer,
                                                  onTap: (() {
                                                    controller.selectedAnswer(
                                                        answer.identifier);
                                                  }));
                                            }),
                                            separatorBuilder:
                                                ((context, index) =>
                                                    const SizedBox(
                                                      height: 10,
                                                    )),
                                            itemCount: controller
                                                .currentQuestion
                                                .value!
                                                .answers!
                                                .length);
                                      }),
                                ],
                              ),
                            ),
                          ),
                        )),
                      ColoredBox(
                        color: customScaffoldColor(context),
                        child: Padding(
                          padding: UIParameters.mobileScreenPadding,
                          child: Row(
                            children: [
                              Visibility(
                                  visible: controller.isFirstQuestion,
                                  child: SizedBox(
                                    height: 55,
                                    width: 55,
                                    child: MainButton(
                                      onTap: (() {
                                        controller.prevQuestion();
                                      }),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Get.isDarkMode
                                            ? onSurfaceTextColor
                                            : Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Visibility(
                                    visible: controller.loadingStatus.value ==
                                        LoadingStatus.completed,
                                    child: MainButton(
                                      onTap: (() {
                                        controller.isLastQuestion
                                            ? Get.toNamed('/testOverview')
                                            : controller.nextQuestion();
                                      }),
                                      title: controller.isLastQuestion
                                          ? 'Complete'
                                          : 'Next',
                                      child: null,
                                    )),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
