import 'package:blinktrack/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserService {
  static Future<void> loadUserData(WidgetRef ref) async {
    final user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists) {
        final data = userDoc.data();

        final userstate = ref.read(userProvider.notifier);
        final updatedCircleDetails =
            Map<String, dynamic>.from(userstate.state.circleDetails);

        if (data != null && data['circles'] != null) {
          final circles = List<String>.from(data['circles']);
          for (var circleId in circles) {
            final circleName = await FirebaseFirestore.instance
                .collection('circles')
                .doc(circleId)
                .get()
                .then((value) => value.data()?['name'] ?? 'Unnamed Circle');
            updatedCircleDetails[circleId] = circleName;
          }
        }
        userstate.state = userstate.state.copyWith(
            name: data?['name'] ?? 'Unknown',
            userId: user.uid,
            circleDetails: updatedCircleDetails);
        print('updatedCircleDetails: $updatedCircleDetails');
      }
    }
  }
}
