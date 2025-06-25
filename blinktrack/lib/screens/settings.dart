import 'package:blinktrack/screens/circlemanage.dart';
import 'package:blinktrack/components/bottomnavigationbar.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/screens/sosscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  int _selectedIndex = 3;
  bool _locationEnabled = false;
  bool _physactEnabled = false;
  bool _bluetoothEnabled = false;
  bool _notificationEnabled = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController _panicword = TextEditingController();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundColor: Colors.grey[200],
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'James Clear',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '+91 8472848293',
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Location Sharing',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
              ),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Panic Word',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _panicword,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Panic Word',
                          hintStyle:
                              const TextStyle(fontSize: 12, color: Colors.grey),
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
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(23.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Push Notifications',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
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
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Delete Account',
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavigationbar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
            switch (index) {
              case 0:
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Mapscreen()));
                break;
              case 1:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CircleManagement()));
                break;
              case 2:
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SosScreen()));
                break;
              case 3:
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Settings()));
                break;
            }
          }),
    );
  }
}
