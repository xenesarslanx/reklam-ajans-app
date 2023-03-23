import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onur_reklam/view/login.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:
     DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: AnimatedSplashScreen(
      backgroundColor: Colors.white,
      splash: Image.asset('lib/assets/splash.png'),
      nextScreen: const LoginUsers(),
      splashIconSize: 400,
      splashTransition: SplashTransition.fadeTransition,
    ),
  ));

}
