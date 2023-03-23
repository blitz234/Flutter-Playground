import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_app/firebase_ref/references.dart';
import 'package:study_app/screen/login/login_screen.dart';
import 'package:study_app/widgets/dialogs_widget.dart';

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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final credential = GoogleAuthProvider.credential(
            idToken: _authAccount.idToken,
            accessToken: _authAccount.accessToken);

        await _auth.signInWithCredential(credential);
        await saveUser(account);

        if (_user.value != null) {
          Get.back();
        }
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
    }
  }

  saveUser(GoogleSignInAccount account) {
    userRF.doc(account.email).set({
      "email": account.email,
      "name": account.displayName,
      "profilePic": account.photoUrl,
    });
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/intro");
  }

  void showLoginAlertDialog() {
    Get.dialog(
        Dialogs().questionStartDialogue(onTap: () {
          Get.back();
          // Navigate to login page
          navigateToLogin();
        }),
        barrierDismissible: false);
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  void navigateToLogin() {
    Get.toNamed(LoginScreen.routename);
  }
}
