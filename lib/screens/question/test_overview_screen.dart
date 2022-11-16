import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sure_learn_electrical/configs/themes/custom_text_style.dart';
import 'package:sure_learn_electrical/configs/themes/ui_parameters.dart';
import 'package:sure_learn_electrical/controllers/question_paper/questions_controller.dart';
import 'package:sure_learn_electrical/screens/home/question_card.dart';
import 'package:sure_learn_electrical/widgets/common/background_decoration.dart';
import 'package:sure_learn_electrical/widgets/common/custom_app_bar.dart';
import 'package:sure_learn_electrical/widgets/common/main_button.dart';
import 'package:sure_learn_electrical/widgets/content_area.dart';
import 'package:sure_learn_electrical/widgets/questions/answer_card.dart';
import 'package:sure_learn_electrical/widgets/questions/countdown_timer.dart';
import 'package:sure_learn_electrical/widgets/questions/question_number_card.dart';

class TestOverviewScreen extends GetView<QuestionsController> {
  const TestOverviewScreen({super.key});

  static const String routeName = "/testoverview";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: controller.completedTest),
      extendBodyBehindAppBar: true,
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: ContentArea(
                child: Column(
                  children: [
                    Row(
                      children: [
                        CoutdownTimer(
                          time: '',
                          color: UIParameters.isDarkMode()
                              ? Theme.of(context).textTheme.bodyText1!.color
                              : Theme.of(context).primaryColor,
                        ),
                        Obx(
                          (() => Text(
                                '${controller.time} Remaining',
                                style: countdownTimerTs(),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: Get.width ~/ 75,
                            childAspectRatio: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8),
                        itemBuilder: (_, index) {
                          AnswerStatus? _answerStatus;
                          if (controller.allQuestions[index].selectedAnswer !=
                              null) {
                            _answerStatus = AnswerStatus.answered;
                          }

                          return QuestionNUmberCard(
                              index: index + 1,
                              status: _answerStatus,
                              onTap: () => controller.jumpToQuestion(index));

                          // Text(
                          //   '${controller.allQuestions[index].selectedAnswer != null}',
                          //   style: TextStyle(fontSize: 20),
                          // );
                        },
                        itemCount: controller.allQuestions.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ColoredBox(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: UIParameters.mobileScreenPadding,
                child: MainButton(
                  onTap: () {
                    controller.complete();
                  },
                  title: 'Complete',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
