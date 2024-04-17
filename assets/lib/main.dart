import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rstreamingent/SplashScreen.dart';
import 'package:rstreamingent/phone.dart';
import 'PushNotification/Notify.dart';
import 'auth_page.dart';
import 'fire_Function.dart';
import 'firebase_options.dart';
import 'home.dart'; // Import your FirebaseService class

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotifications();


  //
  // Platform  Firebase App Id
  // web       1:1027574717774:web:7545bccbc0ef599623921f
  // android   1:1027574717774:android:35230ccb7922453e23921f
  // ios       1:1027574717774:ios:531db378ee88242723921f
  // macos     1:1027574717774:ios:44b60e5bc2d3604223921f
  //

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: {
      'phone': (context) => MyPhone(),
      'home1': (context) => HomePage(),
    },
  ));
}
