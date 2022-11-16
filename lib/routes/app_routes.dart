import 'package:get/get.dart';
import 'package:sure_learn_electrical/controllers/question_paper/question_paper_controller.dart';
import 'package:sure_learn_electrical/controllers/question_paper/questions_controller.dart';
import 'package:sure_learn_electrical/controllers/zoom_drawer_controller.dart';
import 'package:sure_learn_electrical/screens/home/home_screen.dart';
import 'package:sure_learn_electrical/screens/introduction/introduction.dart';
import 'package:sure_learn_electrical/screens/login/login_screen.dart';
import 'package:sure_learn_electrical/screens/question/answer_check_screen.dart';
import 'package:sure_learn_electrical/screens/question/question_screen.dart';
import 'package:sure_learn_electrical/screens/question/test_overview_screen.dart';
import 'package:sure_learn_electrical/widgets/questions/result_screen.dart';

import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => const SplashScreen()),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
          name: "/home",
          page: () => const HomeScreen(),
          binding: BindingsBuilder(
            () {
              Get.put(QuestionPaperController());
              Get.put(MyZoomDrawerController());
            },
          ),
        ),
        GetPage(
          name: LoginScreen.routName,
          page: (() => LoginScreen()),
        ),
        GetPage(
          name: QuestionsScreen.routeName,
          page: (() => QuestionsScreen()),
          binding: BindingsBuilder(
            () {
              Get.put<QuestionsController>(QuestionsController());
            },
          ),
        ),
        GetPage(
          name: TestOverviewScreen.routeName,
          page: () => const TestOverviewScreen(),
        ),
        GetPage(
          name: ResultScreen.routeName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
      ];
}
