import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';
import 'package:sure_learn_electrical/configs/themes/app_colors.dart';
import 'package:sure_learn_electrical/configs/themes/app_icons.dart';
import 'package:sure_learn_electrical/configs/themes/custom_text_style.dart';
import 'package:sure_learn_electrical/configs/themes/ui_parameters.dart';
import 'package:sure_learn_electrical/controllers/question_paper/question_paper_controller.dart';
import 'package:sure_learn_electrical/controllers/zoom_drawer_controller.dart';
import 'package:sure_learn_electrical/screens/home/question_card.dart';
import 'package:sure_learn_electrical/widgets/app_circle_button.dart';
import 'package:sure_learn_electrical/widgets/content_area.dart';

class HomeScreen extends GetView<MyZoomDrawerController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    QuestionPaperController _questionPaperController = Get.find();
    return Scaffold(
      body: GetBuilder<MyZoomDrawerController>(
        builder: (_) {
          return ZoomDrawer(
            controller: _.zoomDrawerController,
            menuScreen: Text("Hi There", style: TextStyle(color: Colors.red)),
            mainScreen: Container(
              decoration: BoxDecoration(gradient: mainGradient()),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(mobileScreenPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppCircleButton(
                            child: Icon(AppIcons.menuLeft),
                            onTap: controller.toogleDrawer,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  AppIcons.peace,
                                ),
                                Text(
                                  'Hello friend',
                                  style: detailText.copyWith(
                                      color: onSurfaceTextColor),
                                )
                              ],
                            ),
                          ),
                          const Text(
                            "What do you want to learn today?",
                            style: headerText,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ContentArea(
                          addPadding: false,
                          child: Obx(
                            () => ListView.separated(
                                padding: UIParameters.mobileScreenPadding,
                                itemBuilder: (BuildContext context, int index) {
                                  return QuestionCard(
                                    model: _questionPaperController
                                        .allPapers[index],
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                                itemCount:
                                    _questionPaperController.allPapers.length),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
