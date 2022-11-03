import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sure_learn_electrical/bindings/initial_binding.dart';
import 'package:sure_learn_electrical/data_uploader_screen.dart';
import 'package:sure_learn_electrical/firebase_options.dart';
import 'package:sure_learn_electrical/routes/app_routes.dart';
import 'package:sure_learn_electrical/screens/introduction/introduction.dart';
import 'package:sure_learn_electrical/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitialBindings().dependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: AppRoutes.routes(),
    );
  }
}


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(GetMaterialApp(
//     home: DataUploaderScreen(),
//   ));
// }
