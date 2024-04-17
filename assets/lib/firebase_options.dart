// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoSePApHcF2iif84dv6j15dyDyn4xBof0',
    appId: '1:1027574717774:web:7545bccbc0ef599623921f',
    messagingSenderId: '1027574717774',
    projectId: 'rstream-15633',
    authDomain: 'rstream-15633.firebaseapp.com',
    storageBucket: 'rstream-15633.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDmrZy_amegjnhcF8d6iEi8OjW0xB9fcxo',
    appId: '1:1027574717774:android:35230ccb7922453e23921f',
    messagingSenderId: '1027574717774',
    projectId: 'rstream-15633',
    storageBucket: 'rstream-15633.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBE6E4BAtp7c33Nc902bYU4IG-08tYJfnE',
    appId: '1:1027574717774:ios:531db378ee88242723921f',
    messagingSenderId: '1027574717774',
    projectId: 'rstream-15633',
    storageBucket: 'rstream-15633.appspot.com',
    androidClientId: '1027574717774-3bc40p8q583a783pb5j1c0sta8roinll.apps.googleusercontent.com',
    iosClientId: '1027574717774-6uiiahperprgmm881lijk08bfru8eum4.apps.googleusercontent.com',
    iosBundleId: 'com.Rstreaming.rstreamingent',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBE6E4BAtp7c33Nc902bYU4IG-08tYJfnE',
    appId: '1:1027574717774:ios:44b60e5bc2d3604223921f',
    messagingSenderId: '1027574717774',
    projectId: 'rstream-15633',
    storageBucket: 'rstream-15633.appspot.com',
    androidClientId: '1027574717774-3bc40p8q583a783pb5j1c0sta8roinll.apps.googleusercontent.com',
    iosClientId: '1027574717774-db505arts5qcli6e4vp1cormr2qe477h.apps.googleusercontent.com',
    iosBundleId: 'com.Rstreaming.rstreamingent.RunnerTests',
  );
}
