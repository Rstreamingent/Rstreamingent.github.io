import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rstreamingent/privacypolicy.dart';
import 'Activity.dart';
import 'aboutus.dart';
import 'bottomAppBar/bottomAppBar.dart';
import 'contact.dart';
import 'stream.dart';
import 'firebase_options.dart';
import 'help.dart';
import 'fire_Function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'fireAPI.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? user = FirebaseAuth.instance.currentUser;

  bool isUsingPhoneLogin = false;

  @override
  void initState() {
    super.initState();
    checkLoginMethod();
  }

  void checkLoginMethod() {
    // Check if the user is logged in using a phone number
    if (user?.providerData[0].providerId == 'phone') {
      setState(() {
        isUsingPhoneLogin = true;
      });
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    // Navigate to HomePage and clear navigation stack
    Navigator.of(context).popUntil((route) => route.isFirst);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Settings',
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: <Widget>[
            // Container for user details
            isUsingPhoneLogin
                ? _buildPhoneLoginDetails()
                : _buildGmailLoginDetails(),
            SizedBox(height: 5,),
            // Container for settings items
            Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xff161a25), // Dark background color
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Column(
                children: [
                  _buildSettingsItem(
                    icon: Icons.group,
                    text: 'About Us',
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => aboutus()));
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.privacy_tip_sharp,
                    text: 'Privacy Policy',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PrivacyPolicyPage()));
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.phone_android,
                    text: 'Contact Us',
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Contact()));
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.star,
                    text: 'Rate Us',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.bug_report,
                    text: 'Report Bug',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ReportBugPage()));
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.access_time_filled_sharp,
                    text: 'Activity',
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => UserActivity()));
                    },
                  ),
                  _buildSettingsItem(
                    icon: Icons.share,
                    text: 'Share with Friends',
                    onTap: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>fireapi()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBarHelper.build(context),
      ),
    );
  }

  Widget _buildSettingsItem(
      {required IconData icon,
        required String text,
        required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24.0),
            SizedBox(width: 20.0),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20.0),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneLoginDetails() {
    String? userEmail;

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;

          if (data != null && data['email'] != null) {
            userEmail = data['email'];
          }

          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff161a25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 40, color: Colors.white),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          user?.phoneNumber ?? "No Phone Number",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.email, size: 40, color: Colors.white),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          userEmail ?? "No Email",
                          style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to allow users to update their email
                    _showEmailInputDialog();
                  },
                  child: Text('Update Email'),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showEmailInputDialog() {
    String newEmail = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor:Color(0xff161a25),
          title: Text("Update Email"),
          content: TextField(
            onChanged: (value) {
              newEmail = value;
            },
            decoration: InputDecoration(hintText: "Enter your email"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                // Save the new email to Firebase
                FirebaseFirestore.instance.collection('users').doc(user?.uid).set({'email': newEmail}, SetOptions(merge: true));
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  Widget _buildGmailLoginDetails() {
    String? userPhoneNumber;


    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? data = snapshot.data?.data() as Map<String, dynamic>?;

          if (data != null && data['phoneNumber'] != null) {
            userPhoneNumber = data['phoneNumber'];
          }

          return Container(
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Color(0xff161a25),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user?.photoURL ?? ""),
                      radius: 30,
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          user?.displayName ?? "User",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.email, size: 40, color: Colors.white),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          user?.email ?? "No Email",
                          style: TextStyle(color: Colors.white, fontSize:15 , fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.phone, size: 40, color: Colors.white),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone Number:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          userPhoneNumber ?? "No Phone Number",
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Add functionality to allow users to update their phone number
                    _showPhoneNumberInputDialog();
                  },
                  child: Text('Update Phone Number'),
                ),
              ],
            ),
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showPhoneNumberInputDialog() {
    String newPhoneNumber = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:Color(0xff161a25),
          title: Text("Update Phone Number",style: TextStyle(color: Colors.white),),
          content: TextField(
            style: TextStyle(color: Colors.white),
            onChanged: (value) {
              newPhoneNumber = value;
            },
            decoration: InputDecoration(labelText: "Enter your phone number" ,labelStyle: TextStyle(color: Colors.white))
            ,
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Save"),
              onPressed: () {
                // Save the new phone number to Firestore
                FirebaseFirestore.instance.collection('users').doc(user?.uid).set({'phoneNumber': newPhoneNumber}, SetOptions(merge: true));
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
