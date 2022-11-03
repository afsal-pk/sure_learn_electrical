import 'package:get/get.dart';
import 'package:sure_learn_electrical/controllers/auth_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
