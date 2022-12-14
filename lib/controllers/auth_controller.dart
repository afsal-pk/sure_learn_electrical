import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sure_learn_electrical/firebase_ref/references.dart';
import 'package:sure_learn_electrical/screens/home/home_screen.dart';
import 'package:sure_learn_electrical/screens/login/login_screen.dart';
import 'package:sure_learn_electrical/utils/app_logger.dart';
import 'package:sure_learn_electrical/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController {
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  late FirebaseAuth _auth;

  final _user = Rxn<User>();

  late Stream<User?> _authStateChanges;

  void initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();

    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();

      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );

        await _auth.signInWithCredential(_credential);
        await saveUser(account);
        navigateToHome();
      }
    } on Exception catch (error) {
      AppLogger.e(error);
    }
  }

  User? getUser() {
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account) {
    userRf.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilepic": account.photoUrl,
    });
  }

  Future<void> signOut() async {
    AppLogger.d('Sign out');
    try {
      await _auth.signOut();
      navigateToHome();
    } on FirebaseAuthException catch (e) {
      AppLogger.e(e);
    }
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  navigateToHome() {
    Get.offAllNamed(HomeScreen.routeName);
  }

  void showLoginAlertDialogue() {
    Get.dialog(
      Dialogs.questionStarDialogue(
        onTap: () {
          Get.back();

          naviagateToLoginPage();
        },
      ),
      barrierDismissible: false,
    );
  }

  void naviagateToLoginPage() {
    Get.toNamed(LoginScreen.routName);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }
}
