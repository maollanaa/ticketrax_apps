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

  // Fetch and filter kereta based on origin and destination
  Future<List<Map<String, dynamic>>> getFilteredKeretaList(
    String origin,
    String destination,
  ) async {
    try {
      QuerySnapshot querySnapshot = await _keretaCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((kereta) =>
              (kereta['stasiun_awal'] == origin ||
                  kereta['kota_awal'] == origin) &&
              (kereta['stasiun_akhir'] == destination ||
                  kereta['kota_akhir'] == destination))
          .toList();
    } catch (e) {
      print("Error fetching filtered kereta: $e");
      return [];
    }
  }
}
