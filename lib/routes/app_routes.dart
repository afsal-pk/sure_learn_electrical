import 'package:get/get.dart';
import 'package:sure_learn_electrical/screens/introduction/introduction.dart';

import '../screens/splash/splash_screen.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(name: "/", page: () => SplashScreen()),
        GetPage(name: "/introduction", page: () => AppIntroductionScreen())
      ];
}
