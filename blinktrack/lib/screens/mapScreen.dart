import 'package:blinktrack/providers/user_provider.dart';
import 'package:blinktrack/screens/circlemanage.dart';
import 'package:blinktrack/components/bottomnavigationbar.dart';
import 'package:blinktrack/components/button.dart';
import 'package:blinktrack/screens/settings.dart';
import 'package:blinktrack/screens/sosscreen.dart';
import 'package:blinktrack/services/user_service.dart';
import 'package:blinktrack/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:geolocator/geolocator.dart';

class Mapscreen extends ConsumerStatefulWidget {
  final String? userid;
  const Mapscreen({super.key, this.userid});

  @override
  ConsumerState<Mapscreen> createState() => _MapscreenConsumerState();
}

var _selectedIndex = 0;
String? _selectedValue;

class _MapscreenConsumerState extends ConsumerState<Mapscreen> {
  static const LatLng _pGooglePlex = LatLng(37.4223, -122.0848);
  static const LatLng _pApplePlex = LatLng(37.4223, -122.0849);
  LatLng? _currentP = null;
  Position? position;
  Map<String, String> circles = {};
  Map<String, dynamic> membersInCircle = {};

  @override
  void initState() {
    super.initState();
    getCirclesDetails();
    saveMyLocationUpdates();
  }

  Future<void> getLocationUpdate() async {
    if (_selectedValue != 'no_circle') {
      final circleref =
          FirebaseDatabase.instance.ref('circles/$_selectedValue/members');
      circleref.onValue.listen((DatabaseEvent event) {
        final rawData = event.snapshot.value;
        if (rawData == null) {
          Fluttertoast.showToast(msg: 'no users in the circle');
          setState(() {
            membersInCircle = {};
          });
          return;
        }

        final data = Map<String, dynamic>.from(rawData as Map);
        print("Members in Circle: $data");
        setState(() {
          membersInCircle = data;
        });
      });
    }
  }

  void getCirclesDetails() async {
    await UserService.loadUserData(ref);
    final userprovd =
        ref.read(userProvider.select((state) => state.circleDetails));
    setState(() {
      circles = Map<String, String>.from(userprovd);
      print("Circles: $circles");
    });
  }

  Future<void> saveMyLocationUpdates() async {
    bool _serviceEnabled;
    LocationPermission locationPermission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location Sevice is denied');
    }
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'You denied the permission');
      }
    }
    if (locationPermission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'You denied the permission forever');
    }
    Position currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      position = currentPosition;
      print("Current Location ${position}");
    });
    final user = FirebaseAuth.instance.currentUser;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    if (userDoc.exists) {
      final data = userDoc.data();
      final circles = data?['circles'];

      if (circles != null && circles is List) {
        for (var circleId in circles) {
          final dbref = await FirebaseDatabase.instance;

          dbref.ref('circles/$circleId/members/${user?.uid}').update({
            'lat': currentPosition.latitude,
            'long': currentPosition.longitude,
            'timestamp': ServerValue.timestamp,
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                  height: 700,
                  child: GoogleMap(
                      // mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(22.123723, 75.609408),
                        //    position?.latitude ?? 0, position?.longitude ?? 0),
                      ),
                      // markers: {
                      //   Marker(
                      //     markerId: MarkerId("_sourceLocation"),
                      //     icon: BitmapDescriptor.defaultMarker,
                      //     position: LatLng(
                      //         position?.latitude ?? 0, position?.longitude ?? 0),
                      //   ),
                      // },
                      markers: membersInCircle.isNotEmpty
                          ? membersInCircle.entries.map((member) {
                              final lat = double.tryParse(
                                      member.value['lat']?.toString() ?? '') ??
                                  0;
                              final long = double.tryParse(
                                      member.value['long']?.toString() ?? '') ??
                                  0;
                              return Marker(
                                markerId: MarkerId(member.key),
                                icon: BitmapDescriptor.defaultMarker,
                                position: LatLng(lat, long),
                              );
                            }).toSet()
                          : {
                              Marker(
                                markerId: MarkerId("_sourceLocation"),
                                icon: BitmapDescriptor.defaultMarker,
                                position: LatLng(position?.latitude ?? 0,
                                    position?.longitude ?? 0),
                              )
                            })),
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
                        items: circles.isNotEmpty
                            ? circles.entries.map((circle) {
                                return DropdownMenuItem<String>(
                                  value: circle.key,
                                  child: Text(
                                    circle.value,
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                );
                              }).toList()
                            : const [
                                DropdownMenuItem<String>(
                                  value: 'no_circle',
                                  child: Text(
                                    'No Circle Available',
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19),
                                  ),
                                ),
                              ],
                        onChanged: (value) async {
                          setState(() {
                            _selectedValue = value;
                          });
                          await getLocationUpdate();
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
              // case 3:
              //   Navigator.pushReplacement(context,
              //       MaterialPageRoute(builder: (context) => Settings()));
              //   break;
            }
          }),
    );
  }
}
