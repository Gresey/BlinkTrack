import 'package:blinktrack/screens/loginscreen.dart';
import 'package:blinktrack/screens/signupscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: Image.asset('assets/BlinkTrack.png'),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 210,
              child: Image.asset('assets/image.png'),
            ),
            const SizedBox(height: 70),
            const Text(
              'Share your location with family',
              style: TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 0.8), // 60% opacity white
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'and friends in real-time',
              style: TextStyle(
                fontSize: 17,
                color: Color.fromRGBO(255, 255, 255, 0.8), // 60% opacity white

                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 70),
            SizedBox(
              width: 290,
              height: 50,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signupscreen()));
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 17),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          Colors.white.withOpacity(0.8), // 80% opacity

                      foregroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ))),
            ),
            const SizedBox(height: 18),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Loginscreen()));
                    },
                    child:
                        Text('Sign in', style: TextStyle(color: Colors.white)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
