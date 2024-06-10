// trip_db.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TripDB {
  final CollectionReference _tripCollection =
      FirebaseFirestore.instance.collection('trip');

  // Fetch all stations
  Future<List<Map<String, dynamic>>> getTripList() async {
    try {
      QuerySnapshot querySnapshot = await _tripCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching trip: $e");
      return [];
    }
  }
}
