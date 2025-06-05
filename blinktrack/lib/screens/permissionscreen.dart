import 'package:blinktrack/screens/addprofilescreen.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

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
  void main() {
    super.initState();
    _checkInitialPermissions();
  }

  Future<void> _checkInitialPermissions() async {
    final location = await Permission.location.isGranted;
    final bluetooth = await Permission.bluetooth.isGranted;
    final physact = await Permission.activityRecognition.isGranted;
    final notification = await Permission.notification.isGranted;
    setState(() {
      _locationEnabled = location;
      _bluetoothEnabled = bluetooth;
      _physactEnabled = physact;
      _notificationEnabled = notification;
    });
  }

  Future<void> requestLocation() async {
    PermissionStatus status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        _locationEnabled = true;
      });
      Fluttertoast.showToast(msg: 'Location Permission granted');
    } else if (status == PermissionStatus.denied) {
      Fluttertoast.showToast(
          msg:
              'Location Permission denied.Grant the location permission to move forward');
    } else if (status == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
          msg:
              'Permission denied.Grant the location permission to move forward');
      openAppSettings();
    }
  }

  Future<void> requestBluetooth() async {
    PermissionStatus status = await Permission.bluetoothConnect.request();

    if (status == PermissionStatus.granted) {
      setState(() {
        _bluetoothEnabled = true;
      });
      Fluttertoast.showToast(msg: 'Bluetooth Permission granted');
    } else if (status == PermissionStatus.denied) {
      Fluttertoast.showToast(
          msg:
              'Bluetooth Permission denied.Grant the Bluetooth permission to move forward');
    } else if (status == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
          msg:
              'Permission denied.Grant the Bluetooth permission to move forward');
      openAppSettings();
    }
  }

  Future<void> requestPhysicalActivity() async {
    PermissionStatus status = await Permission.activityRecognition.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        _physactEnabled = true;
      });
      Fluttertoast.showToast(msg: 'Physical Activity Permission granted');
    } else if (status == PermissionStatus.denied) {
      Fluttertoast.showToast(
          msg:
              'Physical Activity Permission denied.Grant the permission to move forward');
    } else if (status == PermissionStatus.permanentlyDenied ||
        status == PermissionStatus.restricted) {
      Fluttertoast.showToast(
          msg:
              'Permission denied.Grant the Physical Activity permission to move forward');
      openAppSettings();
    }
  }

  Future<void> requestNotification() async {
    PermissionStatus status = await Permission.notification.request();
    if (status == PermissionStatus.granted) {
      setState(() {
        _notificationEnabled = true;
      });
      Fluttertoast.showToast(msg: 'Notification Permission granted');
    } else if (status == PermissionStatus.denied) {
      Fluttertoast.showToast(
          msg:
              'Notification Permission denied.Grant the Notification permission to move forward');
    } else if (status == PermissionStatus.permanentlyDenied) {
      Fluttertoast.showToast(
          msg:
              'Permission denied.Grant the Notification permission to move forward');
      openAppSettings();
    }
  }

  void checkpermissionsenabled() {
    if (_bluetoothEnabled &&
        _locationEnabled &&
        _notificationEnabled &&
        _physactEnabled) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AddProfileScreen()));
    } else {
      Fluttertoast.showToast(msg: 'Enable all permissions to move forward');
    }
  }

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
                          if (!_locationEnabled) {
                            requestLocation();
                          } else {
                            Fluttertoast.showToast(
                              msg: 'To disable, go to app settings.',
                            );
                            openAppSettings();
                          }
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
                          if (!_physactEnabled) {
                            requestPhysicalActivity();
                          } else {
                            Fluttertoast.showToast(
                              msg: 'To disable, go to app settings.',
                            );
                            openAppSettings();
                          }
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
                        onChanged: (value) async {
                          if (!_bluetoothEnabled) {
                            await requestBluetooth();
                          } else {
                            Fluttertoast.showToast(
                              msg: 'To disable, go to app settings.',
                            );
                            openAppSettings();
                          }
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
                          if (!_notificationEnabled) {
                            requestNotification();
                          } else {
                            Fluttertoast.showToast(
                              msg: 'To disable, go to app settings.',
                            );
                            openAppSettings();
                          }
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
                child: Button(
                  text: 'Continue',
                  onPressed: checkpermissionsenabled,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
