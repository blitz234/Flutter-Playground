import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/custom_text_styles.dart';
import 'package:study_app/controllers/question_paper/questions_controller.dart';
import 'package:study_app/screen/home/result_screen.dart';
import 'package:study_app/widgets/common/background_decoration.dart';
import 'package:study_app/widgets/common/custom_appbar.dart';
import 'package:study_app/widgets/content_area.dart';
import 'package:study_app/widgets/questions/answer_card.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});
  static const String routeName = '/answercheckscreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          (() => Text(
                'Q ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}',
                style: appBarTS,
              )),
        ),
        showActionIcon: true,
        onMenuActionTap: () {
          Get.toNamed(ResultScreen.routeName);
        },
      ),
      body: BackGround(
          child: Obx(() => Column(
                children: [
                  Expanded(
                      child: ContentArea(
                    addPadding: true,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(0),
                      child: Column(
                        children: [
                          Text(
                            '${controller.currentQuestion.value!.question}',
                            style: questionTS,
                          ),
                          GetBuilder<QuestionsController>(
                              id: 'answer_review_list',
                              builder: ((_) {
                                return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 20),
                                    itemBuilder: ((context, index) {
                                      final answer = controller.currentQuestion
                                          .value!.answers![index];

                                      final selectedAnswer = controller
                                          .currentQuestion
                                          .value!
                                          .selectedAnswer;

                                      final correctAnswer = controller
                                          .currentQuestion.value!.correctAnswer;

                                      final String answerText =
                                          '${answer.identifier}. ${answer.answer}';

                                      if (correctAnswer == selectedAnswer &&
                                          answer.identifier == selectedAnswer) {
                                        // correct answer
                                        return CorrectAnswer(
                                            answer: answerText);
                                      } else if (selectedAnswer == null) {
                                        return NotAnswered(answer: answerText);
                                      } else if (correctAnswer !=
                                              selectedAnswer &&
                                          answer.identifier == selectedAnswer) {
                                        return WrongAnswer(answer: answerText);
                                      } else if (correctAnswer ==
                                          answer.identifier) {
                                        return CorrectAnswer(
                                            answer: answerText);
                                      }

                                      return AnswerCard(
                                          answer: answerText,
                                          isSelected: false,
                                          onTap: () {});
                                    }),
                                    separatorBuilder: ((context, index) =>
                                        const SizedBox(
                                          height: 10,
                                        )),
                                    itemCount: controller.currentQuestion.value!
                                        .answers!.length);
                              }))
                        ],
                      ),
                    ),
                  ))
                ],
              ))),
    );
  }
}
