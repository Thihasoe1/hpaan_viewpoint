import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  void sendPasswordResetEmail() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
        'Email is empty!',
        'Please enter your email address',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black54,
        colorText: Colors.white,
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        'Success',
        'Password reset email sent!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on FirebaseAuthException catch (error) {
      Get.snackbar(
        "Firebase Error",
        error.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
