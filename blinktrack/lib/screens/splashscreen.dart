import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/screens/welcomescreen.dart';
import 'package:blinktrack/services/preference_service.dart';
import 'package:blinktrack/services/user_service.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Splashscreen extends ConsumerStatefulWidget {
  const Splashscreen({super.key});

  @override
  ConsumerState<Splashscreen> createState() => _SplashscreenConsumerState();
}

class _SplashscreenConsumerState extends ConsumerState<Splashscreen> {
  Widget _nextScreen = Welcomescreen();
  @override
  void initState() {
    super.initState();
    _setNextScreen();
  }

  Future<void> _setNextScreen() async {
    final islogggedIn = await PreferenceService.isUserLogin();
    if (islogggedIn) {
     
      setState(() {
        _nextScreen = Mapscreen();
      });
    } else {
      setState(() {
        _nextScreen = Welcomescreen();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/BlinkTrack.png',
      nextScreen: _nextScreen,
      backgroundColor: AppColors.primary,
      splashTransition: SplashTransition.fadeTransition,
      duration: 2000,
    );
  }
}
