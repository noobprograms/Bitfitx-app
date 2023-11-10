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
    apiKey: 'AIzaSyCeTBk5BqvwzcmGfwC7zulIeJUSirwl1uM',
    appId: '1:622192024091:web:3124102beb2bb5cb8df6be',
    messagingSenderId: '622192024091',
    projectId: 'bitfitx-app',
    authDomain: 'bitfitx-app.firebaseapp.com',
    storageBucket: 'bitfitx-app.appspot.com',
    measurementId: 'G-YLXC4KQLYE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoZR_EQonDgr2nMcJVC5xB3v0dQi55800',
    appId: '1:622192024091:android:429d8e3fdf0ca4aa8df6be',
    messagingSenderId: '622192024091',
    projectId: 'bitfitx-app',
    storageBucket: 'bitfitx-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBflKEkV8aq6O9cbcNENj4OJ3nwDeUvN1U',
    appId: '1:622192024091:ios:6f489ce2b39b20c78df6be',
    messagingSenderId: '622192024091',
    projectId: 'bitfitx-app',
    storageBucket: 'bitfitx-app.appspot.com',
    iosClientId: '622192024091-p87k9kah040gpgc070lqu26pi96aql8f.apps.googleusercontent.com',
    iosBundleId: 'com.example.bitfitxProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBflKEkV8aq6O9cbcNENj4OJ3nwDeUvN1U',
    appId: '1:622192024091:ios:0e9c14c9d52ad6398df6be',
    messagingSenderId: '622192024091',
    projectId: 'bitfitx-app',
    storageBucket: 'bitfitx-app.appspot.com',
    iosClientId: '622192024091-jkmjsvs5875oistbnqekeeh3qfmtbne3.apps.googleusercontent.com',
    iosBundleId: 'com.example.bitfitxProject.RunnerTests',
  );
}
