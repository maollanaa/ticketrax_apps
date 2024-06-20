// users_db.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDB {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  // Fetch all users
  Future<List<Map<String, dynamic>>> getUserList() async {
    try {
      QuerySnapshot querySnapshot = await _userCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching users: $e");
      return [];
    }
  }

  // Fetch user by email and password
  Future<Map<String, dynamic>?> getUserByEmailAndPassword(
      String email, String password) async {
    try {
      QuerySnapshot querySnapshot = await _userCollection
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print("Error fetching user by email and password: $e");
    }
    return null;
  }
}


