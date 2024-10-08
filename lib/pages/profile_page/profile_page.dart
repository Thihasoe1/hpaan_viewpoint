import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/const/const.dart';
import 'package:hpaan_viewpoint/pages/auth/login_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

import '../../services/translation_service.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileBody();
  }
}

class ProfileBody extends StatefulWidget {
  const ProfileBody({super.key});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String userName = "";

  final userCollection = FirebaseFirestore.instance.collection("Users");
  String? selectedLanguage = 'English';

  @override
  void initState() {
    super.initState();
    selectedLanguage = getSelectedLanguageFromLocale(Get.locale);
  }

  String getSelectedLanguageFromLocale(Locale? locale) {
    if (locale == const Locale('my', 'MM')) {
      return 'Myanmar';
    }
    return 'English';
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Scaffold(
        backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: CustomText(
            text: "Profile".tr,
            fontFamily: "SF-Pro",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Do you want to see your profile? Please login",
                fontFamily: "SF-Pro",
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              // CustomText(
              //   text: "Please login ",
              //   fontFamily: "SF-Pro",
              //   fontSize: 16,
              //   fontWeight: FontWeight.w400,
              // ),
              ScaleTapper(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginPage(),
                    ),
                  );
                },
                child: Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.4,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: CustomText(
                      text: "Login",
                      fontFamily: "SF-Pro",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      appBar: AppBar(
        title: CustomText(
          text: "profile".tr,
          fontFamily: "SF-Pro",
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          DropdownButton<String>(
            value: selectedLanguage,
            padding: EdgeInsets.zero,
            onChanged: (String? newValue) {
              setState(() {
                selectedLanguage = newValue;
                TranslationService.changeLocale(newValue!);
              });
            },
            items: TranslationService.langs.map((String language) {
              return DropdownMenuItem<String>(
                value: language,
                child: Row(
                  children: [
                    //const Icon(Icons.translate, size: 18,color: Colors.blue,),
                    SizedBox(
                      width: 20,
                      height: 10,
                      child: Image.asset(
                        TranslationService.getFlagImage(language),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 6),
                    CustomText(
                      text: language,
                      fontFamily: "SF-Pro",
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.blue,
                    ),
                  ],
                ),
              );
            }).toList(),
            icon: const Icon(
              Icons.arrow_drop_down_rounded,
              size: 24,
              color: Colors.blue,
            ),
            iconSize: 42,
            underline: const SizedBox(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(user.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data?.data() as Map<String, dynamic>;
                TextEditingController nameController =
                    TextEditingController(text: userData['name']);
                TextEditingController emailController =
                    TextEditingController(text: userData['email']);

                String? newValue;
                String? emailNewValue;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal,
                              border: Border.all(
                                width: 4,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            child: Image.asset(
                              "assets/images/avatar.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScaleTapper(
                            onTap: () {
                              Get.defaultDialog(
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom: 20,
                                ),
                                titlePadding: EdgeInsets.zero,
                                title: "",
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: "Name",
                                      fontFamily: "SF-Pro",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(height: 5),
                                    MediaQuery(
                                      data: const MediaQueryData(
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      child: TextFormField(
                                        //key: widget.formKey,
                                        controller: nameController,
                                        cursorColor: Colors.teal,
                                        onChanged: (String? value) {
                                          newValue = value ?? userData['name'];
                                        },
                                        style: const TextStyle(
                                          fontFamily: "SF-Pro",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                        //validator: widget.validator,
                                        //obscureText: !_isVisible && widget.isPassword,
                                        decoration: InputDecoration(
                                          //hintText: "${userData['name']}",
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SF-Pro',
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Colors.teal,
                                              width: 1.4,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              width: 1.4,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 18,
                                            horizontal: 10,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    CustomText(
                                      text: "Email",
                                      fontFamily: "SF-Pro",
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade400,
                                    ),
                                    const SizedBox(height: 5),
                                    MediaQuery(
                                      data: const MediaQueryData(
                                        textScaler: TextScaler.linear(1),
                                      ),
                                      child: TextFormField(
                                        //key: widget.formKey,
                                        controller: emailController,
                                        cursorColor: Colors.teal,
                                        onChanged: (String? value) {
                                          emailNewValue =
                                              value ?? userData['email'];
                                        },
                                        style: const TextStyle(
                                          fontFamily: "SF-Pro",
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                        //validator: widget.validator,
                                        //obscureText: !_isVisible && widget.isPassword,
                                        decoration: InputDecoration(
                                          hintText: "",
                                          hintStyle: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SF-Pro',
                                            color: Colors.grey.shade400,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.8),
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Colors.teal,
                                              width: 1.4,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              width: 1.4,
                                            ),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                            vertical: 18,
                                            horizontal: 10,
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: const BorderSide(
                                              color: Colors.red,
                                              width: 1.4,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ScaleTapper(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      height: 44,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 1,
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          text: "Cancel",
                                          fontFamily: "SF-Pro",
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  ScaleTapper(
                                    onTap: () async {
                                      await userCollection
                                          .doc(user.email)
                                          .update({
                                        "email":
                                            emailNewValue ?? userData['email'],
                                        "name": newValue ?? userData['name'],
                                      });
                                      Get.back();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.amber,
                                      ),
                                      child: Center(
                                        child: CustomText(
                                          text: "Update",
                                          fontFamily: "SF-Pro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                top: 6,
                                bottom: 6,
                                left: 8,
                                right: 10,
                              ),
                              margin: const EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.edit_rounded,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 6),
                                  CustomText(
                                    text: "Edit profile",
                                    fontFamily: "SF-Pro",
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      CustomText(
                        text: "Name",
                        fontFamily: "SF-Pro",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        //controller: _nameController,
                        decoration: InputDecoration(
                          hintText: userData['name'] ?? "",
                          hintStyle: const TextStyle(
                            fontFamily: "SF-Pro",
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "Email",
                        fontFamily: "SF-Pro",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        readOnly: true,
                        //controller: _emailController,

                        decoration: InputDecoration(
                          hintText: userData['email'],
                          hintStyle: const TextStyle(
                            fontFamily: "SF-Pro",
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade200,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ScaleTapper(
                        onTap: () {
                          authController.signOut();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              width: 1,
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.logout_rounded,
                                  size: 20,
                                  color: Colors.red,
                                ),
                                const SizedBox(width: 8),
                                CustomText(
                                  text: "LOG OUT",
                                  fontFamily: "SF-Pro",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text("Have Error");
              }
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.teal,
                ),
              );
            }),
      ),
    );
  }
}
