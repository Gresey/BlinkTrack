import 'package:blinktrack/screens/addprofilescreen.dart';
import 'package:blinktrack/screens/circlemanage.dart';
import 'package:blinktrack/screens/createjoinscreen.dart';
import 'package:blinktrack/screens/loginscreen.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/screens/otp_verificationscreen.dart';
import 'package:blinktrack/screens/permissionscreen.dart';
import 'package:blinktrack/screens/settings.dart';
import 'package:blinktrack/screens/signupscreen.dart';
import 'package:blinktrack/screens/sosscreen.dart';
import 'package:blinktrack/screens/splashscreen.dart';
import 'package:blinktrack/screens/welcomescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyD7jVQwuo6Ag8wCa2NVRC9TMSIGSn__31M",
            authDomain: "blinktrack.firebaseapp.com",
            projectId: "blinktrack",
            storageBucket: "blinktrack.firebasestorage.app",
            messagingSenderId: "359649560707",
            appId: "1:359649560707:web:d6fce285f9b96ca531f3b6",
            measurementId: "G-WB87KG41MS"));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'BlinkTrack',
        home: Splashscreen(),
      ),
    );
  }
}
