import 'package:cloud_firestore/cloud_firestore.dart';

final fireStore = FirebaseFirestore.instance;
final questionPaperRf = fireStore.collection('questionPapers');

DocumentReference questionRF({
  required String paperId,
  required String questionId,
}) =>
    questionPaperRf.doc(paperId).collection("questions").doc(questionId);
