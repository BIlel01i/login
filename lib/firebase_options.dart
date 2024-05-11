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
        return ios;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBVVDTo6dd9AIZJjh1bTadEnSC_69byqHo',
    appId: '1:30956675347:web:bba6654b3c18823a27fae6',
    messagingSenderId: '30956675347',
    projectId: 'tawhidalogin',
    authDomain: 'tawhidalogin.firebaseapp.com',
    storageBucket: 'tawhidalogin.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCq6biBeu2wDCXmjUnCgz-2D5-IzQ5MZSw',
    appId: '1:30956675347:android:7b30b533ae96c78c27fae6',
    messagingSenderId: '30956675347',
    projectId: 'tawhidalogin',
    storageBucket: 'tawhidalogin.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBALOHo9a9tNqhZtP5NfGJ1RKS0Gm3qNwQ',
    appId: '1:30956675347:ios:52b747ad2e92b46f27fae6',
    messagingSenderId: '30956675347',
    projectId: 'tawhidalogin',
    storageBucket: 'tawhidalogin.appspot.com',
    iosBundleId: 'com.example.tawhidaLogin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBALOHo9a9tNqhZtP5NfGJ1RKS0Gm3qNwQ',
    appId: '1:30956675347:ios:52b747ad2e92b46f27fae6',
    messagingSenderId: '30956675347',
    projectId: 'tawhidalogin',
    storageBucket: 'tawhidalogin.appspot.com',
    iosBundleId: 'com.example.tawhidaLogin',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBVVDTo6dd9AIZJjh1bTadEnSC_69byqHo',
    appId: '1:30956675347:web:5b75141b06b3319b27fae6',
    messagingSenderId: '30956675347',
    projectId: 'tawhidalogin',
    authDomain: 'tawhidalogin.firebaseapp.com',
    storageBucket: 'tawhidalogin.appspot.com',
  );

}
