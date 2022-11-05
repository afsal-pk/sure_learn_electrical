import 'package:get/get.dart';
import 'package:sure_learn_electrical/controllers/question_paper/question_paper_controller.dart';
import 'package:sure_learn_electrical/screens/home/home_screen.dart';
import 'package:sure_learn_electrical/screens/introduction/introduction.dart';

import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
            name: "/home",
            page: () => HomeScreen(),
            binding: BindingsBuilder(
              () {
                Get.put(QuestionPaperController());
              },
            ))
      ];
}
