import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'home.dart';

class MyOtp extends StatefulWidget {
  String verificationid;
  MyOtp( {super.key, required this.verificationid});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

class _MyOtpState extends State<MyOtp> {
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(), // Set the theme to dark
        home: Scaffold(
          appBar: AppBar(
            title: Text(
              'R STREAMING',
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
          ),
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 160,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Welcome to ',
                      style: TextStyle(fontSize: 22.0),
                    ),
                    Text(
                      'R STREAMING ',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'OTP Authentication ',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: TextField(
                        controller: otpController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            hintText: 'Enter OTP',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            )),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: widget.verificationid,
                              smsCode: otpController.text.toString());
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>HomePage()));
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                    // Navigate to the authentication screen
                    // You'll implement this later
                  },
                  child: Text('Verify'),
                ),
              ],
            ),
          ),
        ));
  }
}
