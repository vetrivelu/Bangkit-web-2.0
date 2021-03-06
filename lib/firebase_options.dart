// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA59lLR53gwHL83m2Npm_IvlGFvd5ud1zE',
    appId: '1:88548732056:web:e6b8426c6c0f0d2f53f4ed',
    messagingSenderId: '88548732056',
    projectId: 'bangkit-83a09',
    authDomain: 'bangkit-83a09.firebaseapp.com',
    storageBucket: 'bangkit-83a09.appspot.com',
    measurementId: 'G-W31Z122M43',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJfcu6BVfn0wsRIZheOdIE7R0MbV2ODcA',
    appId: '1:88548732056:android:5d56c8e6c1365c5353f4ed',
    messagingSenderId: '88548732056',
    projectId: 'bangkit-83a09',
    storageBucket: 'bangkit-83a09.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDG01NYDIhLixBNk32ytHJYIKXt0caOME',
    appId: '1:88548732056:ios:068cea41d97db30653f4ed',
    messagingSenderId: '88548732056',
    projectId: 'bangkit-83a09',
    storageBucket: 'bangkit-83a09.appspot.com',
    androidClientId: '88548732056-bljbapq4o74li7j2cbv67mqrq86tqjhm.apps.googleusercontent.com',
    iosClientId: '88548732056-f6hhavv6sfa91pidevbaiepg6fgo9psk.apps.googleusercontent.com',
    iosBundleId: 'com.techinsight.bangkit',
  );
}
