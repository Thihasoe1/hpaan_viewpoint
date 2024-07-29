import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hpaan_viewpoint/pages/bottom_navigation.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCGOGHMf52jD8BLdB_-EzZoJlrwlPP1OtY',
    appId: '1:1036774234076:android:b72ab00063139cd8a22119',
    messagingSenderId: '1036774234076',
    projectId: 'hpaan-viewpoint',
    storageBucket: 'hpaan-viewpoint.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: "Lato",
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          headlineMedium: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          bodySmall: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      home: const BottomNavBar(),
    );
  }
}
