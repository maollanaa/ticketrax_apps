// users_db.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDB {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Fetch all stations
  Future<List<Map<String, dynamic>>> getUserList() async {
    try {
      QuerySnapshot querySnapshot = await _userCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching user: $e");
      return [];
    }
  }
}


