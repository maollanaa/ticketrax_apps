import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/logged_in_user.dart';

class HistoryDB {
  final CollectionReference _historyCollection =
      FirebaseFirestore.instance.collection('riwayat');

  Future<List<Map<String, dynamic>>> getHistoryList(String email) async {
    try {
      QuerySnapshot querySnapshot = await _historyCollection
          .where('email', isEqualTo: email)
          .get();
      return querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;  // Include the Document ID
        return data;
      }).toList();
    } catch (e) {
      print("Error fetching history: $e");
      return [];
    }
  }
}
