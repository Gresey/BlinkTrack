import 'dart:convert';

import 'package:blinktrack/screens/circlemanage.dart';
import 'package:blinktrack/components/bottomnavigationbar.dart';
import 'package:blinktrack/components/button.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/screens/settings.dart';
import 'package:blinktrack/services/fcm_service.dart';
import 'package:blinktrack/services/notification_service.dart';
import 'package:blinktrack/theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  int _selectedIndex = 2;
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.requestnotificationPermission();
    notificationServices.firebaseInit(context);
    //  notificationServices.isTokenRefresh();
    notificationServices.getDeviceToken().then((value) {
      print('device token');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Members  to whom sos notification will be sent',
              style: TextStyle(
                  color: Colors.black38,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      child: Image.asset('assets/user.png'),
                    ),
                    Text(
                      'Harry',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '+91 8263727489',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Button(text: 'Add Members'),
            SizedBox(
              height: 60,
            ),
            InkWell(
              onTap: () {
                notificationServices.getDeviceToken().then((value) async {
                  var data = {
                    'to':
                        'dKQCTHO4Q_ulUzGfcegrsF:APA91bGCpKxYKNG3c4fqb7uD1HQ2qtrON05HCfu77NpxVs1AH0s7vcs8T3exa7uEZaT5rpHSEamrf5BNvFd_x9lHlxtMMU5e0j9rIeCpo_BPtmSYq7AYbwY',
                    'priority': 'high',
                    'notification': {'title': 'Gracy', 'body': 'Emergency'},
                    'data': {'name': 'Gresey', 'message': 'sos alert'}
                  };
                  await http.post(
                      Uri.parse('https://fcm.googleapis.com/fcm/send'),
                      body: jsonEncode(data),
                      headers: {
                        'Content-Type': 'application/json; charset=UTF-8',
                        'Authorization':
                            'key=89e22bec644a8d6c3c17d9872505d166cc7b0bb6'
                      });
                });
              },
              child: Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(20),
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center, // Center the child

                child: Text(
                  'SOS button',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
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
