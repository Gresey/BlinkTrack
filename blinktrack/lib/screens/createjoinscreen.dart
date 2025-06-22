import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

class JoinCreateCircle extends StatefulWidget {
  const JoinCreateCircle({super.key});

  @override
  State<JoinCreateCircle> createState() => _JoinCreateCircleState();
}

class _JoinCreateCircleState extends State<JoinCreateCircle> {
  final TextEditingController _joincode = TextEditingController();
  final TextEditingController _generatecode = TextEditingController();
  final TextEditingController _circlename = TextEditingController();

  String generateInviteCode({int length = 6}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final randomnum = Random.secure();
    return List.generate(
        length, (index) => chars[randomnum.nextInt(chars.length)]).join();
  }

  Future<void> saveCircleToDatabase() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Fluttertoast.showToast(msg: 'Please ensure you are logged in.');
      return;
    }
    print('user.uid: ${user.uid}');

    final circleDoc = FirebaseFirestore.instance.collection('circles').doc();
    final circleId = circleDoc.id;
    if (_circlename.text.isEmpty) {
      Fluttertoast.showToast(msg: 'Enter circle name');
      return;
    }

    await circleDoc.set({
      'name': _circlename.text,
      'inviteCode': _generatecode.text,
      'createdAt': Timestamp.now(),
      'ownerId': user.uid,
      'members': [user.uid],
    });

    await FirebaseFirestore.instance.collection("users").doc(user.uid).update({
      "circles": circleId,
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    String code = generateInviteCode();
                    _generatecode.text = code;
                  },
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
                height: 10,
              ),
              SizedBox(
                width: 260,
                child: TextFormField(
                  controller: _circlename,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Name of circle',
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
              child: Button(
                text: 'Continue',
                onPressed: () async {
                  if (_joincode.text.isNotEmpty) {
                  } else if (_generatecode.text.isNotEmpty) {
                    await saveCircleToDatabase();
                  } else {}
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Mapscreen()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
