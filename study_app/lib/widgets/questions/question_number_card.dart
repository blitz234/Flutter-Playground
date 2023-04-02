import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';

import 'answer_card.dart';

class QuestionNumberCard extends StatelessWidget {
  const QuestionNumberCard(
      {super.key, required this.index, this.status, this.onTap});
  final int index;
  final AnswerStatus? status;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Theme.of(context).primaryColor;
    switch (status) {
      case AnswerStatus.answered:
        backgroundColor = Get.isDarkMode
            ? Theme.of(context).cardColor
            : Theme.of(context).primaryColor;
        break;
      case AnswerStatus.correct:
        backgroundColor = correctAnswerColor;
        break;
      case AnswerStatus.wrong:
        backgroundColor = wrongAnswerColor;
        break;
      case AnswerStatus.notAnswered:
        backgroundColor = Get.isDarkMode
            ? Colors.red.withOpacity(0.5)
            : Theme.of(context).primaryColor.withOpacity(0.1);
        break;
      default:
        backgroundColor = Theme.of(context).primaryColor.withOpacity(0.1);
    }
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: UIParameters.cardBorderRadius),
        child: Center(
            child: Text(
          '$index',
          style: TextStyle(
              color: status == AnswerStatus.notAnswered
                  ? Theme.of(context).primaryColor
                  : null),
        )),
      ),
    );
  }
}
