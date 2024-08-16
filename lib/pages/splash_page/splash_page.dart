import 'package:flutter/material.dart';
import 'package:hpaan_viewpoint/components/custom_text.dart';
import 'package:hpaan_viewpoint/pages/auth/login_page.dart';
import 'package:hpaan_viewpoint/pages/auth/register_page.dart';
import 'package:hpaan_viewpoint/pages/widgets/scale_tapper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.30,
              //color: const Color.fromARGB(255, 227, 194, 194),
              width: MediaQuery.of(context).size.width,
              //margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.only(
                left: 100,
                right: 100,
                top: 200,
              ),
              child: Image.asset(
                "assets/images/splash.png",
              ),
            ),
          ),
          SizedBox(
            //color: Colors.amber,
            width: MediaQuery.of(context).size.width,

            //margin: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //const SizedBox(),
                CustomText(
                  text: "Welcome to HPA-AN",
                  fontFamily: "country",
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: "Travel with people. Make new friends.",
                  fontFamily: "country",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 240,
              //color: Colors.pink,
              width: MediaQuery.of(context).size.width,
              //margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  ScaleTapper(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage(),),);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 8,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: CustomText(
                          text: "LOGIN",
                          fontFamily: "SF-Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ScaleTapper(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage(),),);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 8,
                      ),
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.black87,
                      ),
                      child: Center(
                        child: CustomText(
                          text: "SIGN UP",
                          fontFamily: "SF-Pro",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
