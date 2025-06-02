import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class AddProfileScreen extends StatelessWidget {
  const AddProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _name = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                child: CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    Icons.account_circle,
                    color: AppColors.primary,
                    size: 200,
                  ),
                ),
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
              child: Button(text: 'Done'),
            ),
          )
        ],
      ),
    );
  }
}
