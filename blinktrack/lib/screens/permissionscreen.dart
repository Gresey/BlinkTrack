import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class PermissionRequestScreen extends StatefulWidget {
  const PermissionRequestScreen({super.key});

  @override
  State<PermissionRequestScreen> createState() =>
      _PermissionRequestScreenState();
}

class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
  bool _locationEnabled = false;
  bool _physactEnabled = false;
  bool _bluetoothEnabled = false;
  bool _notificationEnabled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Enable Permission to',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                Text('move forward',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22)),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Switch(
                        value: _locationEnabled,
                        onChanged: (value) {
                          setState(() {
                            _locationEnabled = value;
                          });
                        },
                        activeColor: AppColors.primary)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Physical Activity',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Switch(
                        value: _physactEnabled,
                        onChanged: (value) {
                          setState(() {
                            _physactEnabled = value;
                          });
                        },
                        activeColor: AppColors.primary)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Bluetooth',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Switch(
                        value: _bluetoothEnabled,
                        onChanged: (value) {
                          setState(() {
                            _bluetoothEnabled = value;
                          });
                        },
                        activeColor: AppColors.primary)
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Notifications',
                        style: TextStyle(
                            color: Colors.black38,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                    Switch(
                        value: _notificationEnabled,
                        onChanged: (value) {
                          setState(() {
                            _notificationEnabled = value;
                          });
                        },
                        activeColor: AppColors.primary)
                  ],
                ),
              ],
            )),
            //  const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Button(text: 'Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
