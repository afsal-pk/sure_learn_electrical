import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sure_learn_electrical/configs/themes/app_colors.dart';
import 'package:sure_learn_electrical/configs/themes/custom_text_style.dart';
import 'package:sure_learn_electrical/configs/themes/ui_parameters.dart';
import 'package:sure_learn_electrical/controllers/question_paper/questions_controller.dart';
import 'package:sure_learn_electrical/firebase_ref/loading_status.dart';
import 'package:sure_learn_electrical/screens/question/test_overview_screen.dart';
import 'package:sure_learn_electrical/widgets/common/background_decoration.dart';
import 'package:sure_learn_electrical/widgets/common/custom_app_bar.dart';
import 'package:sure_learn_electrical/widgets/common/main_button.dart';
import 'package:sure_learn_electrical/widgets/common/question_place_holder.dart';
import 'package:sure_learn_electrical/widgets/content_area.dart';
import 'package:sure_learn_electrical/widgets/questions/answer_card.dart';
import 'package:sure_learn_electrical/widgets/questions/countdown_timer.dart';

class QuestionsScreen extends GetView<QuestionsController> {
  const QuestionsScreen({super.key});

  static const String routeName = "/questionsScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: const ShapeDecoration(
                shape: StadiumBorder(
                    side: BorderSide(color: onSurfaceTextColor, width: 2))),
            child: Obx(
              () => CoutdownTimer(
                time: controller.time.value,
                color: onSurfaceTextColor,
              ),
            ),
          ),
          showActionIcon: true,
          titleWidget: Obx(
            () => Text(
              "Q. ${(controller.questionIndex.value + 1).toString().padLeft(2, '0')}",
              style: appBarTS,
            ),
          )),
      body: BackgroundDecoration(
          child: Obx(
        () => Column(
          children: [
            if (controller.loadingStatus.value == LoadingStatus.loading)
              const Expanded(child: ContentArea(child: QuestionScreenHolder())),
            if (controller.loadingStatus.value == LoadingStatus.completed)
              Expanded(
                child: ContentArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(top: 25),
                    child: Column(
                      children: [
                        Text(
                          controller.currentQuestion.value!.question,
                          style: questionTS,
                        ),
                        GetBuilder<QuestionsController>(
                            id: 'answers_list',
                            builder: (context) {
                              return ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                  top: 25,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final answer = controller
                                      .currentQuestion.value!.answers[index];
                                  return AnswerCard(
                                    answer:
                                        '${answer.identifier}.${answer.answer}',
                                    onTap: () {
                                      controller
                                          .selectedAnswer(answer.identifier);
                                    },
                                    isSelected: answer.identifier ==
                                        controller.currentQuestion.value!
                                            .selectedAnswer,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 10,
                                ),
                                itemCount: controller
                                    .currentQuestion.value!.answers.length,
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: Row(children: [
                  Visibility(
                    visible: controller.isFirstQuestion,
                    child: SizedBox(
                      width: 55,
                      height: 55,
                      child: MainButton(
                        onTap: () {
                          controller.prevQuestion();
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Get.isDarkMode
                              ? onSurfaceTextColor
                              : Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: controller.loadingStatus.value ==
                          LoadingStatus.completed,
                      child: MainButton(
                        onTap: () {
                          controller.isLastQuestion
                              ? Get.toNamed(TestOverviewScreen.routeName)
                              : controller.nextQuestion();
                        },
                        title: controller.isLastQuestion ? 'Submit' : 'Next',
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
