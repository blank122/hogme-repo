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
    apiKey: 'AIzaSyAxuSRJRXuby0Avcpg_4PI_jkARemdZ5xA',
    appId: '1:772642157948:web:ff23136c568c21ad3f60f9',
    messagingSenderId: '772642157948',
    projectId: 'capstoneproj-ecc87',
    authDomain: 'capstoneproj-ecc87.firebaseapp.com',
    storageBucket: 'capstoneproj-ecc87.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9BQcfDh034a5UcDNhhcL3b0tNc5fc-m0',
    appId: '1:772642157948:android:e3ab2e7fac06df8c3f60f9',
    messagingSenderId: '772642157948',
    projectId: 'capstoneproj-ecc87',
    storageBucket: 'capstoneproj-ecc87.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBCw6CzQjA8n8ugGSC4V4X1aRhL2SinbiM',
    appId: '1:772642157948:ios:a1081520488a7b783f60f9',
    messagingSenderId: '772642157948',
    projectId: 'capstoneproj-ecc87',
    storageBucket: 'capstoneproj-ecc87.appspot.com',
    iosBundleId: 'com.example.hogmeUserProd',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBCw6CzQjA8n8ugGSC4V4X1aRhL2SinbiM',
    appId: '1:772642157948:ios:b75bd56e714597903f60f9',
    messagingSenderId: '772642157948',
    projectId: 'capstoneproj-ecc87',
    storageBucket: 'capstoneproj-ecc87.appspot.com',
    iosBundleId: 'com.example.hogmeUserProd.RunnerTests',
  );
}