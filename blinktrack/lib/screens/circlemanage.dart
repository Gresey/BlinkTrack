import 'package:blinktrack/screens/components/appbar.dart';
import 'package:blinktrack/screens/components/bottomnavigationbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/mapScreen.dart';
import 'package:blinktrack/screens/settings.dart';
import 'package:blinktrack/screens/sosscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class CircleManagement extends StatefulWidget {
  const CircleManagement({super.key});

  @override
  State<CircleManagement> createState() => _CircleManagementState();
}

class _CircleManagementState extends State<CircleManagement> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'My Circles',
            style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 24),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 35.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Invite Code',
                style: TextStyle(color: Colors.black38),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 50,
            width: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Family',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
                Text(
                  '1298',
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Button(
                text: '+   Create Circle',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CreateCircle()));
                }),
          ),
        ],
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

class CreateCircle extends StatelessWidget {
  const CreateCircle({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController _circlename = TextEditingController();
    TextEditingController _generatecode = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Circle',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 260,
              child: TextFormField(
                controller: _circlename,
                keyboardType: TextInputType.name,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter Circle Name',
                  hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            SizedBox(
              height: 50,
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
                      fontSize: 17),
                )),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 260,
              child: TextFormField(
                controller: _generatecode,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintStyle: const TextStyle(fontSize: 16, color: Colors.grey),
                  isDense: true,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              height: 50,
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
        ),
      ),
    );
  }
}
