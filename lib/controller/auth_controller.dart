// ignore_for_file: invalid_return_type_for_catch_error

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hpaan_viewpoint/pages/auth/login_page.dart';
import '../const/const.dart';
import '../pages/bottom_navigation.dart';
import '../pages/splash_page/splash_page.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  late Rx<GoogleSignInAccount?> googleSignInAccount;

  var isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }

  @override
  void onReady() {
    super.onReady();
    // auth is coming from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const SplashPage());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const BottomNavBar());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
    debugPrint("$googleSignInAccount");
    if (googleSignInAccount == null) {
      Get.offAll(() => const LoginPage());
    } else {
      Get.offAll(() => const BottomNavBar());
    }
  }

   signInWithGoogle() async {
    try {

      GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final googleUserName = googleSignInAccount.displayName ?? "Unknown username";

        UserCredential userCredential = await auth.signInWithCredential(credential).catchError((onErr) {
          debugPrint("error==================> $onErr");
        });

        createUserDocument(userCredential, googleUserName);

      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      print("error =============> ${e.toString()}");
    }

  }


  void register(String email, password, username) async {
    try {
      setLoading(true);
      UserCredential? userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(username);

      createUserDocument(userCredential, username);
    } on FirebaseAuthException catch (error) {
      Get.snackbar("Something wrong", error.toString());
    } catch (firebaseAuthException) {
      Get.snackbar("Error", firebaseAuthException.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> createUserDocument(
      UserCredential? userCredential, String userName) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'name': userName,
      });
    }
  }

  void login(String email, password) async {
    try {
      setLoading(true);
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
          "Invalid email and password", "Please create account first!");
      debugPrint(error.toString());
    } catch (e) {
      Get.snackbar("Error", e.toString());
      //throw Exception("Login Error");
    } finally {
      setLoading(false);
    }
  }

  void signOut() async {
    await auth.signOut();
  }
}
