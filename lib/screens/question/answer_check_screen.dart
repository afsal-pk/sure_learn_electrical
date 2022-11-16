import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sure_learn_electrical/configs/themes/custom_text_style.dart';
import 'package:sure_learn_electrical/controllers/question_paper/questions_controller.dart';
import 'package:sure_learn_electrical/widgets/common/background_decoration.dart';
import 'package:sure_learn_electrical/widgets/common/custom_app_bar.dart';
import 'package:sure_learn_electrical/widgets/content_area.dart';
import 'package:sure_learn_electrical/widgets/questions/answer_card.dart';
import 'package:sure_learn_electrical/widgets/questions/result_screen.dart';

class AnswerCheckScreen extends GetView<QuestionsController> {
  const AnswerCheckScreen({super.key});

  static const String routeName = "/answercheckscreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        titleWidget: Obx(
          () => Text(
            'Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, "0")}',
            style: appBarTS,
          ),
        ),
        showActionIcon: true,
        onMenuActionTap: (() {
          Get.toNamed(ResultScreen.routeName);
        }),
      ),
      body: BackgroundDecoration(
          child: Obx(
        () => Column(
          children: [
            Expanded(
              child: ContentArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Text(controller.currentQuestion.value!.question),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<QuestionsController>(
                          id: 'answer_review_list',
                          builder: (_) {
                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (_, index) {
                                final answer = controller
                                    .currentQuestion.value!.answers[index];
                                final selectedAnswer = controller
                                    .currentQuestion.value!.selectedAnswer;
                                final correctAnswer = controller
                                    .currentQuestion.value!.correctAnswer;

                                final String answerText =
                                    '${answer.identifier}.${answer.answer}';

                                if (correctAnswer == selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  return CorrectAnswer(answer: answerText);
                                } else if (selectedAnswer == null) {
                                  return NotAnswer(answer: answerText);
                                } else if (correctAnswer != selectedAnswer &&
                                    answer.identifier == selectedAnswer) {
                                  return WrongAnswer(answer: answerText);
                                } else if (correctAnswer == answer.identifier) {
                                  return CorrectAnswer(answer: answerText);
                                }

                                return AnswerCard(
                                    answer: answerText, onTap: () {});
                              },
                              itemCount: controller
                                  .currentQuestion.value!.answers.length,
                              separatorBuilder: (_, intex) {
                                return const SizedBox(
                                  height: 10,
                                );
                              },
                            );
                          })
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
