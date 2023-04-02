import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:study_app/controllers/auth_controller.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/models/question_paper_model.dart';
import 'package:study_app/services/firebase_storage_service.dart';

import '../../screen/question/question_screen.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;
  final allPaper = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgname = ["biology", "chemistry", "maths", "physics"];
    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRF.get();
      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapshot(paper))
          .toList();

      allPaper.assignAll(paperList);

      for (var paper in paperList) {
        var imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;
      }

      allPaper.assignAll(paperList);
    } catch (e) {
      print(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController _authController = Get.find();
    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();
        Get.toNamed(QuestionScreen.routeName,
            arguments: paper, preventDuplicates: false);
        //Get.offNamed();
      } else {
        Get.toNamed(QuestionScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialog();
    }
  }
}
