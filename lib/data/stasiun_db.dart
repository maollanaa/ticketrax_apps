// stasiundb.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class StasiunDB {
  final CollectionReference _stasiunCollection =
      FirebaseFirestore.instance.collection('daftar_stasiun');

  // Fetch all stations
  Future<List<Map<String, dynamic>>> getStasiunList() async {
    try {
      QuerySnapshot querySnapshot = await _stasiunCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching stasiun: $e");
      return [];
    }
  }
}
