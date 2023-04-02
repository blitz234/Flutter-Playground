import 'package:flutter/material.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/configs/themes/ui_parameter.dart';

enum AnswerStatus { correct, wrong, answered, notAnswered }

class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final VoidCallback? onTap;
  const AnswerCard(
      {super.key,
      required this.answer,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: UIParameters.cardBorderRadius,
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: UIParameters.cardBorderRadius,
            color: isSelected
                ? answerSelectedColor(context)
                : Theme.of(context).cardColor,
            border: Border.all(
                color: isSelected
                    ? answerSelectedColor(context)
                    : answerBorderColor(context))),
        child: Text(
          answer,
          style: TextStyle(
            color: isSelected ? onSurfaceTextColor : null,
          ),
        ),
      ),
    );
  }
}

class CorrectAnswer extends StatelessWidget {
  const CorrectAnswer({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: correctAnswerColor.withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: correctAnswerColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class WrongAnswer extends StatelessWidget {
  const WrongAnswer({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: wrongAnswerColor.withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style: const TextStyle(
            color: wrongAnswerColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotAnswered extends StatelessWidget {
  const NotAnswered({super.key, required this.answer});
  final String answer;
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
          borderRadius: UIParameters.cardBorderRadius,
          color: notAnswerColor.withOpacity(0.3)),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Text(
        answer,
        style:
            const TextStyle(color: notAnswerColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
