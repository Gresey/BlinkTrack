import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/createjoinscreen.dart';
import 'package:blinktrack/screens/permissionscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpVerificationscreen extends StatefulWidget {
  final String otp;
  final String number;
  const OtpVerificationscreen(
      {super.key, required this.otp, required this.number});

  @override
  State<OtpVerificationscreen> createState() => _OtpVerificationscreenState();
}

class _OtpVerificationscreenState extends State<OtpVerificationscreen> {
  bool _isResending = false;
  late String _verificationId;
  final TextEditingController _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _verificationId = widget.otp;
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
    });
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.number,
      verificationCompleted: (credential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Verification failed")),
        );
      },
      codeSent: (verificationId, token) {
        setState(() {
          _verificationId = verificationId;
          _isResending = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP resent!')),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {
        setState(() {
          _verificationId = verificationId;
          _isResending = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 80,
            ),
            Text(
              'Verification',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            Text('Enter your OTP code number',
                style: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: InputDecoration(
                  hintText: 'Enter 6-digit OTP',
                  counterText: '',
                ),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 45.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend Otp',
                      style: TextStyle(
                        color: Colors.black38,
                        decoration: TextDecoration.underline,
                      ),
                    )),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Button(
                    text: 'Verify',
                    onPressed: () async {
                      if (_otpController.text.length != 6) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Please enter a valid 6-digit OTP')),
                        );
                        return;
                      } else {
                        try {
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                            verificationId: widget.otp,
                            smsCode: _otpController.text.trim(),
                          );
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .signInWithCredential(credential);
                          User? user = userCredential.user;
                          if (user != null) {
                            final userdoc = await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .get();
                            if (userdoc.exists) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          JoinCreateCircle()));
                            } else {
                              await userdoc.reference
                                  .set({'phone': widget.number});

                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PermissionRequestScreen()));
                            }
                          }
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.message}')),
                          );
                        }
                      }
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
