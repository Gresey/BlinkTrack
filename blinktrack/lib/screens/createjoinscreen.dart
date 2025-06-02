import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class JoinCreateCircle extends StatelessWidget {
  const JoinCreateCircle({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _joincode = TextEditingController();
    TextEditingController _generatecode = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Join a Circle',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22)),
              SizedBox(
                height: 10,
              ),
              Text(
                'Enter Invite code to join a circle ',
                style: TextStyle(
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 260,
                child: TextFormField(
                  controller: _joincode,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter code',
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none, // No border line
                    ),
                    filled: true,
                    fillColor: AppColors.textfieldbackground,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Text('Don’t have invite code?',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Generate Code',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: AppColors.primary,
                        fontSize: 19),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 260,
                child: TextFormField(
                  controller: _generatecode,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintStyle:
                        const TextStyle(fontSize: 16, color: Colors.grey),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none, // No border line
                    ),
                    filled: true,
                    fillColor: AppColors.textfieldbackground,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('Share the above invite code to family and ',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
              Text('friends and create a circle. ',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold)),
            ],
          )),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(text: 'Continue'),
            ),
          )
        ],
      ),
    );
  }
}
