import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserDetails>((ref) {
  return UserDetails(name: "user", circleDetails: {}, userId: "", fcmToken: "");
});

class UserDetails {
  String name;
  Map<String, dynamic> circleDetails = {};
  String userId;
  String fcmToken;
  UserDetails({
    required this.name,
    required this.userId,
    this.circleDetails = const {},
    required this.fcmToken,
  });
  UserDetails copyWith(
      {String? name,
      String? userId,
      Map<String, dynamic>? circleDetails,
      String? fcmToken}) {
    return UserDetails(
        name: name ?? this.name,
        userId: userId ?? this.userId,
        circleDetails: circleDetails ?? this.circleDetails,
        fcmToken: fcmToken ?? this.fcmToken);
  }
}
