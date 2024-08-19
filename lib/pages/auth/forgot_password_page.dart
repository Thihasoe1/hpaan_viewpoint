import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/pages/auth/login_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

import '../../controller/forgot_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    final ForgotPasswordController forgotPasswordController =
        Get.put(ForgotPasswordController());

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Forgot password",
          fontFamily: "SF-Pro",
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width * 0.65,
              child: CustomText(
                text:
                    "Enter your email and we will send you a password reset link.",
                fontFamily: "SF-Pro",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: CustomTextField(
                textEditingController: forgotPasswordController.emailController,
                hintText: "Enter your email",
                validator: (String? value) {
                  if (value == null) {
                    return "please enter your email";
                  }
                  return null;
                },
                textInputType: TextInputType.emailAddress,
              ),
            ),
            const SizedBox(height: 10),
            ScaleTapper(
              onTap: () {
                FocusScope.of(context).unfocus();
                forgotPasswordController.sendPasswordResetEmail();
              },
              child: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomText(
                    text: "Continue",
                    fontFamily: "SF-Pro",
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
