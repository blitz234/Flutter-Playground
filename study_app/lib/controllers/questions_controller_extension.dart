import 'package:study_app/controllers/question_paper/questions_controller.dart';

extension QuestionsControllerExtension on QuestionsController {
  // access the number of correct questions
  int get correctQuestionCount => allQuestions
      .where((element) => element.selectedAnswer == element.correctAnswer)
      .toList()
      .length;

  String get correctAnsweredQuestions {
    return '$correctQuestionCount out of  ${allQuestions.length} are correct';
  }
}
