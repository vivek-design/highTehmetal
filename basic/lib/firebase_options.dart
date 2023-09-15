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
    apiKey: 'AIzaSyAPG1qPKdNa16GbqMKZVu-T-vuuaazFf5I',
    appId: '1:747249998495:web:61615d4eebf54f600de0aa',
    messagingSenderId: '747249998495',
    projectId: 'hi-tech-metals',
    authDomain: 'hi-tech-metals.firebaseapp.com',
    databaseURL: 'https://hi-tech-metals-default-rtdb.firebaseio.com',
    storageBucket: 'hi-tech-metals.appspot.com',
    measurementId: 'G-4Y692JW0SJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDO7xLVCiTrNp-b5Ww4KJ03EPcDlW2g2BI',
    appId: '1:747249998495:android:a91dbae6745834390de0aa',
    messagingSenderId: '747249998495',
    projectId: 'hi-tech-metals',
    databaseURL: 'https://hi-tech-metals-default-rtdb.firebaseio.com',
    storageBucket: 'hi-tech-metals.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD0_8yrmfpEWEYfGg5DJKekIMS8GDWumQ0',
    appId: '1:747249998495:ios:650a253d072240bc0de0aa',
    messagingSenderId: '747249998495',
    projectId: 'hi-tech-metals',
    databaseURL: 'https://hi-tech-metals-default-rtdb.firebaseio.com',
    storageBucket: 'hi-tech-metals.appspot.com',
    iosClientId: '747249998495-3tgout7bvschdfpooet9s2bcl93vq9sp.apps.googleusercontent.com',
    iosBundleId: 'com.example.basic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD0_8yrmfpEWEYfGg5DJKekIMS8GDWumQ0',
    appId: '1:747249998495:ios:650a253d072240bc0de0aa',
    messagingSenderId: '747249998495',
    projectId: 'hi-tech-metals',
    databaseURL: 'https://hi-tech-metals-default-rtdb.firebaseio.com',
    storageBucket: 'hi-tech-metals.appspot.com',
    iosClientId: '747249998495-3tgout7bvschdfpooet9s2bcl93vq9sp.apps.googleusercontent.com',
    iosBundleId: 'com.example.basic',
  );
}
