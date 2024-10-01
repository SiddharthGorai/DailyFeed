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
    apiKey: 'AIzaSyCtGk6U1Lp_A6Tj32ccM4OxI3a5k0mgEmE',
    appId: '1:324226504893:web:3d0ecad684b212a7e67fd4',
    messagingSenderId: '324226504893',
    projectId: 'news-4368e',
    authDomain: 'news-4368e.firebaseapp.com',
    storageBucket: 'news-4368e.appspot.com',
    measurementId: 'G-04ZY52J3LC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8P8bYV1RpkWmM0J4UHDR86rZsjkqN-T8',
    appId: '1:324226504893:android:4322004b872f1955e67fd4',
    messagingSenderId: '324226504893',
    projectId: 'news-4368e',
    storageBucket: 'news-4368e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHKH1mSC-kIycGZzknpPqQhIdWN4qK2-s',
    appId: '1:324226504893:ios:d2a70bf4153e2014e67fd4',
    messagingSenderId: '324226504893',
    projectId: 'news-4368e',
    storageBucket: 'news-4368e.appspot.com',
    iosBundleId: 'com.example.news',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDHKH1mSC-kIycGZzknpPqQhIdWN4qK2-s',
    appId: '1:324226504893:ios:f313784ecc784fafe67fd4',
    messagingSenderId: '324226504893',
    projectId: 'news-4368e',
    storageBucket: 'news-4368e.appspot.com',
    iosBundleId: 'com.example.news.RunnerTests',
  );
}
