import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class OtpVerificationscreen extends StatelessWidget {
  const OtpVerificationscreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    TextEditingController _controller2 = TextEditingController();
    TextEditingController _controller3 = TextEditingController();
    TextEditingController _controller4 = TextEditingController();
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: TextFormField(
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _controller,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: TextFormField(
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _controller2,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: TextFormField(
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _controller3,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                  ),
                ),
                SizedBox(
                  width: 13,
                ),
                Container(
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                  child: TextFormField(
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    controller: _controller4,
                    style: const TextStyle(fontSize: 20),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                      isDense: false,
                    ),
                  ),
                ),
              ],
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
                  child: Button(text: 'Verify')),
            ),
          ],
        ),
      ),
    );
  }
}
