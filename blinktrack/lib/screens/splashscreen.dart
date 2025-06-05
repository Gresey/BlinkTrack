import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blinktrack/screens/welcomescreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/BlinkTrack.png',
      nextScreen: Welcomescreen(),
      backgroundColor: AppColors.primary,
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
