import 'dart:convert';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:study_app/firebase_ref/loading_status.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';

class DataUploader extends GetxController {
  @override
  void onReady() {
    uploadData();
    super.onReady();
  }

  final laodingStatus = LoadingStatus.loading.obs;

  void uploadData() async {
    final firestore = FirebaseFirestore.instance;
    // manifestContent includes all the assets that we specified in pubspec.yaml file
    final manifestContent = await DefaultAssetBundle.of(Get.context!)
        .loadString("AssetManifest.json");

    // here we get a map of files and their paths
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);

    // since we are trying to load json file here(the question papers) we are only interested in
    // assets present in DB folder, so we sort the results present in manifestMap
    final papersInAssets = manifestMap.keys
        .where((path) =>
            path.startsWith("assets/DB/paper") && path.contains(".json"))
        .toList();

    // list of question papers
    List<QuestionPaperModel> questionPapers = [];

    for (var paper in papersInAssets) {
      // Finally load the json files
      String stringPaperContent = await rootBundle.loadString(paper);

      // Use the model to parse json and add its instance to the question paper list
      // remember to decode json which converts the string to map
      questionPapers
          .add(QuestionPaperModel.fromJson(json.decode(stringPaperContent)));
    }
    debugPrint("items: ${questionPapers.length}");

    var batch = firestore.batch();

    for (var paper in questionPapers) {
      batch.set(questionPaperRF.doc(paper.id), {
        "title": paper.title,
        "image_url": paper.imageUrl,
        "description": paper.description,
        "time_seconds": paper.timeSeconds,
        "questions_count":
            (paper.questions == null) ? 0 : paper.questions!.length,
      });

      for (var questions in paper.questions!) {
        final questionPath =
            questionRF(paperId: paper.id!, questionId: questions.id!);
        batch.set(questionPath, {
          "question": questions.question,
          "correct_answer": questions.correctAnswer
        });

        for (var answer in questions.answers!) {
          batch.set(questionPath.collection('anwers').doc(answer.identifier),
              {"identifier": answer.identifier, "answer": answer.answer});
        }
      }
    }

    await batch.commit();
    laodingStatus.value = LoadingStatus.completed;
  }
}
