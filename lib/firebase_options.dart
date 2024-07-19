// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCyfER2JXK6Ny97EghlCTCzDU4FK6ir1OQ',
    appId: '1:273734979703:android:910e4db3bb61d3c10d7672',
    messagingSenderId: '273734979703',
    projectId: 'assesment-740f9',
    storageBucket: 'assesment-740f9.appspot.com',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBvEnCGoV-hj_BvaTC_FDjgowxTzP12sp8',
    appId: '1:273734979703:web:4cf9d0c5f884a5930d7672',
    messagingSenderId: '273734979703',
    projectId: 'assesment-740f9',
    authDomain: 'assesment-740f9.firebaseapp.com',
    storageBucket: 'assesment-740f9.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDzhBOMrxkk3PyNQHgkT5RUy469COphl6s',
    appId: '1:273734979703:ios:a476475758fb5d980d7672',
    messagingSenderId: '273734979703',
    projectId: 'assesment-740f9',
    storageBucket: 'assesment-740f9.appspot.com',
    iosBundleId: 'com.example.cta',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvEnCGoV-hj_BvaTC_FDjgowxTzP12sp8',
    appId: '1:273734979703:web:4a73388619ef21f00d7672',
    messagingSenderId: '273734979703',
    projectId: 'assesment-740f9',
    authDomain: 'assesment-740f9.firebaseapp.com',
    storageBucket: 'assesment-740f9.appspot.com',
  );

}