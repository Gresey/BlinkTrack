import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProvider = StateProvider<UserDetails>((ref) {
  return UserDetails(name: "user", circleDetails: {}, userId: "");
});

class UserDetails {
  String name;
  Map<String, dynamic> circleDetails = {};
  String userId;
  UserDetails({
    required this.name,
    required this.userId,
    this.circleDetails = const {},
  });
  UserDetails copyWith(
      {String? name,
      String? circleId,
      String? userId,
      Map<String, dynamic>? circleDetails}) {
    return UserDetails(
        name: name ?? this.name,
        userId: userId ?? this.userId,
        circleDetails: circleDetails ?? this.circleDetails);
  }
}
