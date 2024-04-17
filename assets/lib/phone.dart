import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'bottomAppBar/bottomAppBar.dart';
import 'fire_Function.dart';
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
  TextEditingController OtpController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final _formkey1 = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Set the theme to dark
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 180,
                ),
                Text(
                  'सुस्वागतम्',
                  style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold,color: Colors.white),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Image.asset('assets/icons/R-streaming-TEXT-logo.png',
                   height:45
                     ,
                   ),

                  ],
                ),

                SizedBox(height: 20.0),
                Text(
                  'कृपया आपला मोबाईल नंबर प्रदान करा',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey ,fontWeight: FontWeight.bold),
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
                          controller:PhoneController ,
                          keyboardType: TextInputType.phone,

                          decoration: InputDecoration(
                              prefixText: '+91 ',prefixStyle:TextStyle(color: Colors.white,fontSize: 16.5),
                              border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(24),

                          )),
                            validator:(value){
                            if(value!.length!=10){
                              return "invalid number";
                            }else{
                              return null;
                            }
                            }

                           , style: TextStyle(color: Colors.white),
                        ),

                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      // Call sentOtp method from AuthService
                      AuthService.sentOtp(
                        phone: PhoneController.text,
                        errorStep: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error Sending OTP'))),
                        nextStep: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('OTP Verification'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Enter OTP'),
                                SizedBox(height: 12,),
                                Form(
                                  key: _formkey1,
                                  child: TextFormField(
                                    controller: OtpController,

                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(

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
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  if (_formkey1.currentState!.validate()) {
                                    AuthService.loginWithOtp(otp: OtpController.text).then((value) {
                                      if (value == 'success') {
                                        Navigator.pop(context);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                                      } else {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value)));
                                      }
                                    });
                                  }
                                  BottomNavigationBarHelper.setIndex(0);
                                },
                                child: Text('Submit'),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                  child: Text('Send OTP'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    surfaceTintColor:Color(0xffFFF200) ,
                    foregroundColor: Colors.black,
                  ),
                ),

                SizedBox(height: 20,),
                Divider(thickness: 1,indent: 25,endIndent: 25,),
                SizedBox(height: 20,),
                 Text('OR', style: TextStyle(fontSize: 20,color: Colors.white70)),
                SizedBox(height: 30),
                SizedBox(
                 child:Container(
                   decoration:BoxDecoration(
                     color: Colors.white,
                     borderRadius: BorderRadius.circular(25)
                   ),
                   child: TextButton(
                        onPressed: (){
                          FirebaseService.signInwithGoogle(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [

                            Image.asset(
                              'assets/icons/google.png',
                              height:25,
                              width: 25,
                            ),
                            SizedBox(width: 10,),

                            Text("Sign in with google ",style: TextStyle(color: Color(
                                0xff1b46f5),)
                                                ),



                          ],
                        ),
                 ),
                 )
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
}