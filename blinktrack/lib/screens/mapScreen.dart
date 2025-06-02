import 'package:blinktrack/screens/circlemanage.dart';
import 'package:blinktrack/screens/components/bottomnavigationbar.dart';
import 'package:blinktrack/screens/components/button.dart';
import 'package:blinktrack/screens/settings.dart';
import 'package:blinktrack/screens/sosscreen.dart';
import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Mapscreen extends StatefulWidget {
  const Mapscreen({super.key});

  @override
  State<Mapscreen> createState() => _MapscreenState();
}

var _selectedIndex = 0;
String? _selectedValue;

class _MapscreenState extends State<Mapscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 600,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: DropdownButton<String>(
                        value: _selectedValue,
                        hint: const Text(
                          'Choose Circle',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        iconEnabledColor: AppColors.primary,
                        items: const [
                          DropdownMenuItem(
                            value: 'Family',
                            child: Text(
                              'Family',
                              style: TextStyle(
                                  // fontSize: 22,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                          ),
                          DropdownMenuItem(
                            value: 'Home',
                            child: Text(
                              'Home',
                              style: TextStyle(
                                  //  fontSize: 22,
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedValue = value);
                        },
                      ),
                    ),
                  ),
                  //Icon(Icons.group_rounded),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Member List',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black38,
                        child: SizedBox(
                          child: Image.asset('assets/user.png'),
                        ),
                      ),
                      Text('John'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.battery_3_bar,
                            size: 17,
                            color: Colors.black45,
                          ),
                          Text(
                            '50',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'At Home',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black38,
                        child: SizedBox(
                          child: Image.asset('assets/user.png'),
                        ),
                      ),
                      Text('John'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.battery_3_bar,
                            size: 17,
                            color: Colors.black45,
                          ),
                          Text(
                            '50',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'At Home',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black38,
                        child: SizedBox(
                          child: Image.asset('assets/user.png'),
                        ),
                      ),
                      Text('John'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.battery_3_bar,
                            size: 17,
                            color: Colors.black45,
                          ),
                          Text(
                            '50',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'At Home',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black38,
                        child: SizedBox(
                          child: Image.asset('assets/user.png'),
                        ),
                      ),
                      Text('John'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.battery_3_bar,
                            size: 17,
                            color: Colors.black45,
                          ),
                          Text(
                            '50',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'At Home',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.black38,
                        child: SizedBox(
                          child: Image.asset('assets/user.png'),
                        ),
                      ),
                      Text('John'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.battery_3_bar,
                            size: 17,
                            color: Colors.black45,
                          ),
                          Text(
                            '50',
                            style:
                                TextStyle(color: Colors.black45, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'At Home',
                        style: TextStyle(
                            color: Colors.black38,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 280,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Add Members to the Family circle',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.primary, // 80% opacity

                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ))),
            ),
            SizedBox(
              height: 20,
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
