import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rstreamingent/phone.dart';
import 'bottomAppBar/bottomAppBar.dart';
import 'home.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user is logged in
          if (snapshot.hasData) {
            BottomNavigationBarHelper.setIndex(0);
            return HomePage();
          }
          if(snapshot.hasError){
            return Text(snapshot.error.toString(),
            );
          }
          // user is NOT logged in
          else {
            return MyPhone();
          }
        },
      ),
    );
  }
}
