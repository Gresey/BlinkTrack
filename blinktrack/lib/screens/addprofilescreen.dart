import 'dart:io';

import 'package:blinktrack/components/button.dart';
import 'package:blinktrack/screens/createjoinscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AddProfileScreen extends StatefulWidget {
  const AddProfileScreen({super.key});

  @override
  State<AddProfileScreen> createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  bool _camerapermission = false;
  File? _profileImage;
  TextEditingController _name = TextEditingController();

  Future<void> pickImagefromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        //  uploadFile();
      });
    }
  }

  Future uploadFile() async {
    if (_profileImage == null) return;
    final fileName = basename(_profileImage!.path);
    final destination = 'files/$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_profileImage!);
    } catch (e) {
      print('error occured');
    }
  }

  Future<void> saveImageToDatabase() async {
    final user = FirebaseAuth.instance.currentUser;
    final name = _name.text.trim();

    if (user == null || name.isEmpty) {
      Fluttertoast.showToast(
          msg: 'Please enter your name and ensure you are logged in.');
      return;
    }

    try {
      String? imageUrl;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'name': name,
        'phone': user.phoneNumber,
        // 'profilePicture': imageUrl ?? '',
        'locationSharing': true,
        'lastActive': FieldValue.serverTimestamp(),
      });
      // if (_profileImage != null) {
      //   final fileName = basename(_profileImage!.path);
      //   final destination = 'profile_images/$fileName';

      //   final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
      //   await ref.putFile(_profileImage!);

      //   imageUrl = await ref.getDownloadURL();
      // }

      // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
      //   'name': name,
      //   'phone': user.phoneNumber,
      //   'profilePicture': imageUrl ?? '',
      //   'locationSharing': true,
      //   'lastActive': FieldValue.serverTimestamp(),
      // });

      Fluttertoast.showToast(msg: 'Profile saved successfully!');
      //Navigator.pop(); // or navigate to home/dashboard
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error saving profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 90,
                    backgroundColor:
                        AppColors.primary, // Match avatar background
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : null,
                    child: _profileImage == null
                        ? Icon(
                            Icons.person,
                            color: AppColors.background, // Match icon color
                            size: 180,
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 4,
                    right: 7,
                    child: InkWell(
                      onTap: pickImagefromGallery,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.background,
                        ),
                        height: 48,
                        width: 48,
                        child: Center(
                          child: Icon(
                            Icons.camera_alt,
                            size: 32,
                            color: Colors.black54,
                            weight:
                                800, // Only available in Flutter 3.10+, otherwise omit
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Add Profile Picture',
                style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                'It will appear as bubble on the map',
                style: TextStyle(color: AppColors.primary, fontSize: 13),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 290,
                child: TextFormField(
                  controller: _name,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle:
                        const TextStyle(fontSize: 15, color: Colors.grey),
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
                  style: const TextStyle(fontSize: 15),
                ),
              ),
            ],
          )),

          //   const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Button(
                text: 'Done',
                onPressed: () {
                  saveImageToDatabase();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JoinCreateCircle()));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
