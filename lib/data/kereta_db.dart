// kereta_db.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class KeretaDB {
  final CollectionReference _keretaCollection =
      FirebaseFirestore.instance.collection('daftar_kereta');

  // Fetch all stations
  Future<List<Map<String, dynamic>>> getKeretaList() async {
    try {
      QuerySnapshot querySnapshot = await _keretaCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching kereta: $e");
      return [];
    }
  }
}
