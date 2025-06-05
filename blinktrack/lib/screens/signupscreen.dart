import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/otp_verificationscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _number = TextEditingController();
    String _selectedCountryCode = '+91';
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            'Let \'s get Started! ',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            'What\'s your number?',
            style: TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          Text('A Code will be sent to verify your number',
              style: TextStyle(color: Colors.black38, fontSize: 12)),
          const SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CountryCodePicker(
                initialSelection: 'IN',
                showCountryOnly: true,
                alignLeft: false,
                onChanged: (country) {
                  setState(() {
                    _selectedCountryCode = country.dialCode ?? '+91';
                  });
                },
              ),
              //const SizedBox(width: 1),
              SizedBox(
                width: 180,
                child: TextFormField(
                  controller: _number,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Enter your Number',
                    hintStyle:
                        const TextStyle(fontSize: 14, color: Colors.grey),
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
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(
                  text: 'Continue',
                  onPressed: () async {
                    if (_number.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Enter your number")));
                      return;
                    } else {
                      String number = (_number.text).trim();
                      if (number.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter your number")));
                      } else if (number.length != 10) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Enter a valid number")));
                      } else {
                        try {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                              verificationCompleted: (credential) {},
                              verificationFailed: (error) {},
                              codeSent: (otp, token) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => OtpVerificationscreen(
                                            otp: otp,
                                            number:
                                                "$_selectedCountryCode$number")));
                              },
                              codeAutoRetrievalTimeout: (otp) {},
                              phoneNumber: "$_selectedCountryCode$number");
                        } on FirebaseAuthException catch (err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(err.code.toString())));
                        }
                      }
                    }
                  },
                )),
          ),
        ],
      ),
    );
  }
}
