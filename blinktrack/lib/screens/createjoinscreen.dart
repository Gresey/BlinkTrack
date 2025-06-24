import 'package:blinktrack/providers/user_provider.dart';
import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:fluttertoast/fluttertoast.dart';

class JoinCreateCircle extends ConsumerStatefulWidget {
  const JoinCreateCircle({super.key});

  @override
  ConsumerState<JoinCreateCircle> createState() => _JoinCreateCircleState();
}

class _JoinCreateCircleState extends ConsumerState<JoinCreateCircle> {
  final TextEditingController _joincode = TextEditingController();
  final TextEditingController _generatecode = TextEditingController();
  final TextEditingController _circlename = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  String generateInviteCode({int length = 6}) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final randomnum = Random.secure();
    return List.generate(
        length, (index) => chars[randomnum.nextInt(chars.length)]).join();
  }

  Future<void> saveCircleToDatabase() async {
    if (user == null) {
      Fluttertoast.showToast(msg: 'Please ensure you are logged in.');
      return;
    }
    print('user.uid: ${user?.uid}');

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
      'ownerId': user?.uid,
      'members': [user!.uid],
    });

    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "circles": FieldValue.arrayUnion([circleId]),
    });
  }

  Future<void> joinCircle() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('circles')
        .where('inviteCode', isEqualTo: _joincode.text)
        .limit(1)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      final circledoc = querySnapshot.docs.first;
      await FirebaseFirestore.instance
          .collection('circles')
          .doc(circledoc.id)
          .update({
        'members': FieldValue.arrayUnion([user?.uid]),
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user?.uid)
          .update({
        'circles': FieldValue.arrayUnion([circledoc.id])
      });
      final circlename = await FirebaseFirestore.instance
          .collection('circles')
          .doc(circledoc.id)
          .get()
          .then((value) => value.data()?['name'] ?? 'Unnamed Circle');
    } else {
      Fluttertoast.showToast(
          msg: 'No existing circle for this invite code. Create a new circle.');
      return;
    }
  }

  Future<void> fetchAllCircles() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Fluttertoast.showToast(msg: 'User not logged in');
      return;
    }

    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (querySnapshot.exists) {
      final provider = ref.read(userProvider.notifier);
      final updatedCircleDetails =
          Map<String, dynamic>.from(provider.state.circleDetails);
      final data = querySnapshot.data();
      if (data != null && data['circles'] != null) {
        final circles = List<String>.from(data['circles']);
        for (var circleId in circles) {
          final circleName = await FirebaseFirestore.instance
              .collection('circles')
              .doc(circleId)
              .get()
              .then((value) => value.data()?['name'] ?? 'Unnamed Circle');
          updatedCircleDetails[circleId] = circleName;
        }
        provider.state =
            provider.state.copyWith(circleDetails: updatedCircleDetails);
        print('updatedCircleDetails: $updatedCircleDetails');
      }
    }
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
                  keyboardType: TextInputType.text,
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
                    await joinCircle();
                    await fetchAllCircles();
                    Fluttertoast.showToast(msg: 'Circle joined successfully');
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Mapscreen()));
                  } else if (_generatecode.text.isNotEmpty) {
                    await saveCircleToDatabase();
                    await fetchAllCircles();
                    Fluttertoast.showToast(msg: 'Circle created successfully');

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Mapscreen()));
                  } else {
                    Fluttertoast.showToast(msg: 'Enter any value');
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
