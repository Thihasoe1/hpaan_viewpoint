import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/const/const.dart';
import 'package:hpaan_viewpoint/pages/widgets/custom_text_field.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Sign Up",
                    fontFamily: "SF-Pro",
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                  CustomText(
                    text: "Hello! register to get started.",
                    fontFamily: "SF-Pro",
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF696969),
                  ),
                  const SizedBox(height: 40),
                  CustomText(
                    text: "Name",
                    fontFamily: "SF-Pro",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF696969),
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    textEditingController: _nameController,
                    hintText: "Enter your name",
                  ),
                  const SizedBox(height: 14),
                  CustomText(
                    text: "Email",
                    fontFamily: "SF-Pro",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF696969),
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    textEditingController: _emailController,
                    hintText: "Enter your email (eg. xxx@gmail.com)",
                  ),
                  const SizedBox(height: 14),
                  CustomText(
                    text: "Password",
                    fontFamily: "SF-Pro",
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF696969),
                  ),
                  const SizedBox(height: 4),
                  CustomTextField(
                    textEditingController: _passwordController,
                    isPassword: true,
                    hintText: "Enter your password",
                    textInputType: TextInputType.number,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            ScaleTapper(
              onTap: () async {
                authController.register(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomText(
                    text: "Sign Up",
                    fontFamily: "SF-Pro",
                    fontSize: 15,
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
