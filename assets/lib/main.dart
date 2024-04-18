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
    // options: DefaultFirebaseOptions.currentPlatform,
    options: FirebaseOptions(
        apiKey: "AIzaSyCoSePApHcF2iif84dv6j15dyDyn4xBof0",
        projectId: "rstream-15633",
        messagingSenderId: "1027574717774",
        appId: "1:1027574717774:web:b521d5d48799434123921f" )

//oAuth client id = 1027574717774-l18qn49vlink67030ioeul12fav000sh.apps.googleusercontent.com
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
//
// // Import the functions you need from the SDKs you need
// import { initializeApp } from "firebase/app";
// // TODO: Add SDKs for Firebase products that you want to use
// // https://firebase.google.com/docs/web/setup#available-libraries
//
// // Your web app's Firebase configuration
// const firebaseConfig = {
//   apiKey: "AIzaSyCoSePApHcF2iif84dv6j15dyDyn4xBof0",
//   authDomain: "rstream-15633.firebaseapp.com",
//   projectId: "rstream-15633",
//   storageBucket: "rstream-15633.appspot.com",
//   messagingSenderId: "1027574717774",
//   appId: "1:1027574717774:web:b521d5d48799434123921f"
// };
//
// // Initialize Firebase
// const app = initializeApp(firebaseConfig);