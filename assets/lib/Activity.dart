// ignore_for_file: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'fire_Function.dart';
// Import your FirebaseService class
import 'auth_service.dart';

class UserActivity extends StatefulWidget {
  const UserActivity({Key? key}) : super(key: key);

  @override
  State<UserActivity> createState() => _UserActivityState();
}

class _UserActivityState extends State<UserActivity> {
  late String deviceName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize deviceName
    deviceName = 'Loading...';
    getDeviceName();
  }

  Future<void> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    try {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceName = iosInfo.name ?? 'Unknown Device';
      } else {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceName = androidInfo.device ?? 'Unknown Device';
      }
    } catch (e) {
      print('Error getting device info: $e');
    }

    // Update the state to reflect the changes
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> logout() async {
    // Sign out of Firebase
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    // // Create an instance of FirebaseService and call signOutFromGoogle
     FirebaseService firebaseService = FirebaseService();
    await firebaseService.signOutFromGoogle();
    // // Navigate to MyPhone page
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => MyPhone()),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/icons/R-streaming-TEXT-logo.png',
                  height: 50,
                ),
                Text(
                  "Thank you for joining R STREAMING entertainment:",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(height: 2,),
                SizedBox(height: 10,)
              ],
            ),
          ),
          Padding(

            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Device Name: $deviceName',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              onPressed: logout,
              icon: Icon(
                Icons.logout,
                color: Colors.red,
                size: 20,
              ),
              label: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
