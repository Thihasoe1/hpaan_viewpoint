import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/const/const.dart';
import 'package:hpaan_viewpoint/pages/auth/login_page.dart';
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
  final formKey = GlobalKey<FormState>();

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
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    //height: MediaQuery.of(context).size.height * 0.52,
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your name";
                            }
                            return null;
                          },
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
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
                        const SizedBox(height: 30),
                        Obx(
                          () => authController.isLoading.value
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.teal,
                                    ),
                                  ),
                                )
                              : ScaleTapper(
                                  onTap: () async {
                                    if (formKey.currentState!.validate()) {
                                      authController.register(
                                        _emailController.text.trim(),
                                        _passwordController.text.trim(),
                                        _nameController.text.trim(),
                                      );
                                    }
                                  },
                                  child: Container(
                                    //margin: const EdgeInsets.symmetric(horizontal: 16),
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
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
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Already have an account? ",
                              fontFamily: "SF-Pro",
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF696969),
                            ),
                            ScaleTapper(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage(),),);
                              },
                              child: CustomText(
                                text: " Sign In",
                                fontFamily: "SF-Pro",
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
    required this.validator,
  });

  final TextEditingController textEditingController;
  final String hintText;
  final TextInputType? textInputType;
  final bool isPassword;
  final String? Function(String?)? validator;

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
      data: const MediaQueryData(textScaler: TextScaler.linear(1),),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.textEditingController,
        cursorColor: Colors.teal,
        keyboardType: widget.textInputType,
        style: const TextStyle(
          fontFamily: "SF-Pro",
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
        obscureText: !_isVisible && widget.isPassword,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle:  TextStyle(
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.red,
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
