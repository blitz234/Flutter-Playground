import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app/configs/themes/app_colors.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/controllers/question_paper/question_paper_controller.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/screen/home/home_screen.dart';
import 'package:study_app/screen/home/result_screen.dart';
import 'package:study_app/controllers/questions_controller_extension.dart';

import '../../firebase_ref/references.dart';

class QuestionsController extends GetxController {
  var loadingStatus = LoadingStatus.loading.obs;
  late QuestionPaperModel questionPaperModel;
  late final allQuestions = <Questions>[];
  final questionIndex = 0.obs;
  bool get isFirstQuestion => questionIndex.value > 0;
  Rxn<Questions> currentQuestion = Rxn<Questions>();
  bool get isLastQuestion => questionIndex.value >= allQuestions.length - 1;

  //Timer
  Timer? _timer;
  int remainSeconds = 1;
  final time = '00:00'.obs;

  @override
  void onReady() {
    final _questionPaper = Get.arguments as QuestionPaperModel;
    debugPrint(_questionPaper.title);
    loadData(_questionPaper);
    super.onReady();
  }

  void loadData(QuestionPaperModel questionPaper) async {
    loadingStatus.value = LoadingStatus.loading;
    questionPaperModel = questionPaper;

    try {
      final QuerySnapshot<Map<String, dynamic>> questionQuery =
          await questionPaperRF
              .doc(questionPaper.id)
              .collection("questions")
              .get();

      final questions =
          questionQuery.docs.map(((e) => Questions.fromSnapshot(e))).toList();
      questionPaper.questions = questions;
      for (Questions questions in questionPaper.questions!) {
        final QuerySnapshot<Map<String, dynamic>> answersQuery =
            await questionPaperRF
                .doc(questionPaper.id)
                .collection("questions")
                .doc(questions.id)
                .collection("anwers")
                .get();

        final answers = answersQuery.docs
            .map((answer) => Answers.fromSnapshot(answer))
            .toList();
        questions.answers = answers;

        // debugPrint(answers.length.toString());
      }
      if (questionPaper.questions != null &&
          questionPaper.questions!.isNotEmpty) {
        allQuestions.assignAll(questionPaper.questions!);
        currentQuestion.value = allQuestions[0];
        _startTimer(questionPaper.timeSeconds!);
      }
      loadingStatus.value = LoadingStatus.completed;
    } on Exception catch (e) {
      debugPrint(e.toString());
      loadingStatus.value = LoadingStatus.error;
    }
  }

  void selectedAnswer(String? answer) {
    currentQuestion.value!.selectedAnswer = answer;
    update(['answers_list', 'answer_review_list']);
  }

  void nextQuestion() {
    if (questionIndex.value >= allQuestions.length - 1) {
      return;
    }
    questionIndex.value++;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  void prevQuestion() {
    if (questionIndex.value <= 0) {
      return;
    }
    questionIndex.value--;
    currentQuestion.value = allQuestions[questionIndex.value];
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainSeconds = seconds;
    _timer = Timer.periodic(duration, (timer) {
      if (remainSeconds == 0) {
        complete();
      } else {
        int minutes = remainSeconds ~/ 60;
        int seconds = remainSeconds % 60;
        time.value =
            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainSeconds--;
      }
    });
  }

  void jumpToQuestion(int index, {bool isGoBack = true}) {
    questionIndex.value = index;
    currentQuestion.value = allQuestions[index];
    if (isGoBack) {
      Get.back();
    }
  }

  String get completedTest {
    final answered = allQuestions
        .where(((element) => element.selectedAnswer != null))
        .toList()
        .length;
    return "$answered out of ${allQuestions.length} answered";
  }

  void complete() {
    _timer!.cancel();
    Get.offAndToNamed(ResultScreen.routeName);
  }

  int get totalScore {
    int score = correctQuestionCount * 5;
    return score;
  }

  void tryAgain() {
    currentQuestion.value = allQuestions[0];
    questionIndex.value = 0;
    Get.find<QuestionPaperController>()
        .navigateToQuestions(paper: questionPaperModel, tryAgain: true);
  }

  Future<void> saveTestResults() async {
    var batch = firestore.batch();
    User? user = Get.find<AuthController>().getUser();
    if (user == null) {
      return;
    }
    batch.set(
        userRF
            .doc(user.email)
            .collection('my_recent_tests')
            .doc(questionPaperModel.id),
        {
          "points": totalScore,
          "correct_answer": '$correctQuestionCount/${allQuestions.length}'
        });
    batch.commit();
    navigateToHome();
  }
}

void navigateToHome() {
  Get.offNamedUntil('/home', (route) => false);
}
