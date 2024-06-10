// history_db.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryDB {
  final CollectionReference _historyCollection =
      FirebaseFirestore.instance.collection('history');

  // Fetch all stations
  Future<List<Map<String, dynamic>>> getHistoryList() async {
    try {
      QuerySnapshot querySnapshot = await _historyCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching history: $e");
      return [];
    }
  }
}
