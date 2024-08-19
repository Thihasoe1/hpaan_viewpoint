import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/pages/auth/forgot_password_page.dart';
import 'package:hpaan_viewpoint/pages/auth/register_page.dart';
import '../../components/custom_text.dart';
import '../../const/const.dart';
import '../widgets/scale_tapper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKeyState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        scrolledUnderElevation: 0.0,
        elevation: 0.0,
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKeyState,
          child: Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: MediaQuery.of(context).size.height * 0.6,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Sign In",
                        fontFamily: "SF-Pro",
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(height: 40),
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email address";
                          }
                          return null;
                        },
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
                        //formKey: formKeyState,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        textEditingController: _passwordController,
                        isPassword: true,
                        hintText: "Enter your password",
                        textInputType: TextInputType.number,
                      ),
                      const SizedBox(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(),
                          ScaleTapper(
                            onTap: () => Get.to(const ForgotPasswordPage()),
                            child: CustomText(
                              text: "Forgot password?",
                              fontFamily: "SF-Pro",
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => authController.isLoading.value
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.teal,
                                  ),
                                ),
                              )
                            : ScaleTapper(
                                onTap: () async {
                                  if (formKeyState.currentState!.validate()) {
                                    authController.login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                  }
                                },
                                child: Container(
                                  //margin: const EdgeInsets.symmetric(horizontal: 16),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: CustomText(
                                      text: "Login",
                                      fontFamily: "SF-Pro",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: "Create new account?",
                            fontFamily: "SF-Pro",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF696969),
                          ),
                          const SizedBox(width: 5),
                          ScaleTapper(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const RegisterPage(),
                                ),
                              );
                            },
                            child: CustomText(
                              text: "Sign Up",
                              fontFamily: "SF-Pro",
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          const SizedBox(width: 6),
                          CustomText(
                            text: "OR",
                            fontFamily: "SF-Pro",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ScaleTapper(
                        onTap: () {
                          authController.signInWithGoogle();
                        },
                        child: Container(
                          height: 55,
                          //margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/google.png"),
                              const SizedBox(width: 14),
                              CustomText(
                                text: "Login with Google",
                                fontFamily: "SF-Pro",
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF696969),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.textInputType,
    this.isPassword = false,
    //required this.formKey,
    required this.validator,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType? textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;
  //final GlobalKey<FormState> formKey;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isVisible = false;

  void setIsVisible() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: const MediaQueryData(
        textScaler: TextScaler.linear(1),
      ),
      child: TextFormField(
        //key: widget.formKey,
        controller: widget.textEditingController,
        cursorColor: Colors.teal,
        keyboardType: widget.textInputType,
        style: const TextStyle(
          fontFamily: "SF-Pro",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        validator: widget.validator,
        obscureText: !_isVisible && widget.isPassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            fontFamily: 'SF-Pro',
            color: Colors.grey.shade400,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.8),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.teal,
              width: 1.4,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              width: 1.4,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.4,
            ),
          ),
          suffixIcon: widget.isPassword
              ? ScaleTapper(
                  onTap: setIsVisible,
                  child: Icon(
                    !_isVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: const Color.fromRGBO(184, 184, 184, 1),
                    size: 22,
                  ),
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
