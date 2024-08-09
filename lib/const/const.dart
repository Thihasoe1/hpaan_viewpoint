import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../controller/auth_controller.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(
    options: const FirebaseOptions(
  apiKey: 'AIzaSyCGOGHMf52jD8BLdB_-EzZoJlrwlPP1OtY',
  appId: '1:1036774234076:android:b72ab00063139cd8a22119',
  messagingSenderId: '1036774234076',
  projectId: 'hpaan-viewpoint',
  storageBucket: 'hpaan-viewpoint.appspot.com',
));
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
GoogleSignIn googleSign = GoogleSignIn();
