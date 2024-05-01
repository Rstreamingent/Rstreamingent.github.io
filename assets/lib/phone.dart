import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bottomAppBar/bottomAppBar.dart';
import 'fire_Function.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_service.dart';
import 'home.dart';

void main() {
  runApp(MyPhone());
}

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController PhoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isOTPSending = false;
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 130,
                ),
                Text(
                  'सुस्वागतम्',
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/R-streaming-TEXT-logo.png',
                      height: 100,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Text(
                  'कृपया आपला मोबाईल नंबर प्रदान करा',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 1),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 500,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          controller: PhoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              prefixText: '+91 ',
                              prefixStyle: TextStyle(
                                  color: Colors.white, fontSize: 16.5),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                              )),
                          validator: (value) {
                            if (value!.length != 10) {
                              return "invalid number";
                            } else {
                              return null;
                            }
                          },
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      setState(() {
                        _isOTPSending = true;
                      });
                      // Call sentOtp method from AuthService
                      AuthService.sentOtp(
                        phone: PhoneController.text,
                          errorStep: () {
                            setState(() {
                              _isOTPSending = false; // Set the value back to false
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error Sending OTP')),
                            );
                          },
                        nextStep: () {
                          _isOTPSending = false;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationScreen(
                                phoneNumber: PhoneController.text,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                  child:_isOTPSending? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ): Text('Send OTP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    surfaceTintColor: Color(0xffFFF200),
                    foregroundColor: Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Divider(
                  thickness: 1,
                  indent: 25,
                  endIndent: 25,
                ),
                SizedBox(height: 20),
                Text('OR',
                    style: TextStyle(fontSize: 20, color: Colors.white70)),
                SizedBox(height: 30),
                SizedBox(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25)),
                    child: TextButton(
                      onPressed: () {
                        FirebaseService.signInwithGoogle(context);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/icons/google.png',
                            height: 25,
                            width: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Sign in with google ",
                            style: TextStyle(color: Color(0xff1b46f5)),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OTPVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  OTPVerificationScreen({required this.phoneNumber});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController OtpController = TextEditingController();
  final _formkey1 = GlobalKey<FormState>();
  bool _isOTPVerifying = false; // Add this line to track OTP verification

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        title: Text(
          'OTP Verification',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                  ),
                  Text(
                    'सुस्वागतम्',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/R-streaming-TEXT-logo.png',
                        height: 100,
                      ),
                    ],
                  ),
                  Text(
                    'Enter 6 digit OTP sent to  ${widget.phoneNumber}',
                    style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Form(
                    key: _formkey1,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, letterSpacing: 20),
                      controller: OtpController,
                      maxLength: 6,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        labelText: 'Enter OTP',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length != 6) {
                          return "Invalid OTP";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _isOTPVerifying
                          ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                      )
                          : ElevatedButton(
                        onPressed: () async {
                          if (_formkey1.currentState!.validate()) {
                            setState(() {
                              _isOTPVerifying = true; // Set the value to true
                            });
                            final value =
                            await AuthService.loginWithOtp(otp: OtpController.text);
                            setState(() {
                              _isOTPVerifying = false; // Set the value back to false
                            });
                            if (value == 'success') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(value)),
                              );
                            }
                            BottomNavigationBarHelper.setIndex(0);
                          }
                        },
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.amber),
                        ),
                      ),
                      Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Change Number?',
                            style: TextStyle(
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.blueAccent,
                                decorationThickness: 2),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}