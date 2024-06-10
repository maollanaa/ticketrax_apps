import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyDMZekTY_knZW8pO-FowNMJnohZj04KjSg',
    appId: '1:256686066254:web:fe8a379833fdedd4ccd11f',
    messagingSenderId: '256686066254',
    projectId: 'ticketrax',
    authDomain: 'ticketrax.firebaseapp.com',
    storageBucket: 'ticketrax.appspot.com',
    measurementId: 'G-05X1PK7Y7K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwF2IoWjzv4DBuAbw71de0E8WJB4yILNY',
    appId: '1:256686066254:android:c9deb0468fa640eeccd11f',
    messagingSenderId: '256686066254',
    projectId: 'ticketrax',
    storageBucket: 'ticketrax.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD9RjDOVCpw7DI5CpziRsM8lw0be6rlPfs',
    appId: '1:256686066254:ios:9a7384fd511b8398ccd11f',
    messagingSenderId: '256686066254',
    projectId: 'ticketrax',
    storageBucket: 'ticketrax.appspot.com',
    iosBundleId: 'com.example.ticketraxApps',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD9RjDOVCpw7DI5CpziRsM8lw0be6rlPfs',
    appId: '1:256686066254:ios:9a7384fd511b8398ccd11f',
    messagingSenderId: '256686066254',
    projectId: 'ticketrax',
    storageBucket: 'ticketrax.appspot.com',
    iosBundleId: 'com.example.ticketraxApps',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDMZekTY_knZW8pO-FowNMJnohZj04KjSg',
    appId: '1:256686066254:web:2afc7b98bd988243ccd11f',
    messagingSenderId: '256686066254',
    projectId: 'ticketrax',
    authDomain: 'ticketrax.firebaseapp.com',
    storageBucket: 'ticketrax.appspot.com',
    measurementId: 'G-D2CHL2X3TK',
  );
}
