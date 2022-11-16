import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sure_learn_electrical/controllers/auth_controller.dart';
import 'package:sure_learn_electrical/firebase_ref/references.dart';
import 'package:sure_learn_electrical/models/question_paper_model.dart';
import 'package:sure_learn_electrical/screens/question/question_screen.dart';
import 'package:sure_learn_electrical/services/firebase_storage_service.dart';
import 'package:sure_learn_electrical/utils/app_logger.dart';

class QuestionPaperController extends GetxController {
  final allPaperImages = <String>[].obs;

  final allPapers = <QuestionPaperModel>[].obs;
  @override
  void onReady() {
    getAllPapers();
    super.onReady();
  }

  Future<void> getAllPapers() async {
    List<String> imgName = ["biology", "chemistry", "maths", "physics"];

    try {
      QuerySnapshot<Map<String, dynamic>> data = await questionPaperRf.get();

      final paperList = data.docs
          .map((paper) => QuestionPaperModel.fromSnapShot(paper))
          .toList();
      allPapers.assignAll(paperList);

      for (var paper in paperList) {
        final imgUrl =
            await Get.find<FirebaseStorageService>().getImage(paper.title);
        paper.imageUrl = imgUrl;

        //  allPaperImages.add(imgUrl!);
      }
      allPapers.assignAll(paperList);
    } catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToQuestions(
      {required QuestionPaperModel paper, bool tryAgain = false}) {
    AuthController _authController = Get.find();

    if (_authController.isLoggedIn()) {
      if (tryAgain) {
        Get.back();

        Get.toNamed(QuestionsScreen.routeName,
            arguments: paper, preventDuplicates: false);
      } else {
        Get.toNamed(QuestionsScreen.routeName, arguments: paper);
      }
    } else {
      _authController.showLoginAlertDialogue();
    }
  }
}
