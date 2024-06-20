import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class HistoryDetailPage extends StatefulWidget {
  final Map<String, dynamic> history;

  const HistoryDetailPage({required this.history, Key? key}) : super(key: key);

  @override
  _HistoryDetailPageState createState() => _HistoryDetailPageState();
}

class _HistoryDetailPageState extends State<HistoryDetailPage> {
  late Future<String> qrCodeUrl;
  late String status;

  @override
  void initState() {
    super.initState();
    qrCodeUrl = fetchQrCode(widget.history['id']);
    status = widget.history['status'];
    updateStatusIfPastArrival();
  }

  // Fungsi untuk memperbarui status transaksi jika sudah melewati waktu tiba
  Future<void> updateStatusIfPastArrival() async {
    final Timestamp? hariTiba = widget.history['hari_tiba'];
    if (hariTiba != null && status == 'AKTIF') {
      final DateTime arrivalDate = hariTiba.toDate();
      final DateTime now = DateTime.now();
      if (now.isAfter(arrivalDate)) {
        await updateStatus('SELESAI');
      }
    }
  }

  // Fungsi untuk mengupdate status transaksi ke status baru
  Future<void> updateStatus(String newStatus) async {
    try {
      await FirebaseFirestore.instance
          .collection('riwayat')
          .doc(widget.history['id'])
          .update({'status': newStatus});
      setState(() {
        status = newStatus;
      });
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  // Fungsi untuk mengambil URL QR Code dari server berdasarkan invoice
  Future<String> fetchQrCode(String invoice) async {
    final response = await http.get(Uri.parse(
        'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$invoice'));
    if (response.statusCode == 200) {
      return 'https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$invoice';
    } else {
      throw Exception('Gagal memuat QR code');
    }
  }

  // Fungsi untuk memformat tanggal menjadi teks yang mudah dibaca
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '-';
    final dayName = DateFormat('EEEE', 'id_ID').format(dateTime);
    final day = dateTime.day;
    final month = DateFormat('MMMM', 'id_ID').format(dateTime);
    final year = dateTime.year;
    return '$dayName, $day $month $year';
  }

  // Fungsi untuk memformat waktu menjadi teks yang mudah dibaca
  String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('HH:mm').format(dateTime);
  }

  // Fungsi untuk membatalkan pesanan
  Future<void> cancelOrder() async {
    try {
      await updateStatus('DIBATALKAN');
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp? waktuTransaksi = widget.history['waktu'];
    final Timestamp? hariAwal = widget.history['hari_awal'];
    final Timestamp? hariTiba = widget.history['hari_tiba'];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF797EF6), Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Detail Riwayat',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna tombol kembali
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Detail Transaksi',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      buildSection([
                        buildDetailRow('ID Transaksi', widget.history['id']),
                        if (waktuTransaksi != null)
                          buildDetailRow(
                              'Waktu Transaksi',
                              DateFormat('dd MMM yyyy, HH:mm', 'id_ID')
                                  .format(waktuTransaksi.toDate())),
                        buildStatusRow('Status', status),
                      ]),
                      Divider(thickness: 2, height: 40),
                      buildSection([
                        buildDetailRow('Nama Kereta', widget.history['nama']),
                        buildDetailRow(
                            'Stasiun Awal', widget.history['stasiun_awal']),
                        buildDetailRow(
                            'Stasiun Akhir', widget.history['stasiun_akhir']),
                        buildDetailRow('Waktu Berangkat',
                            '${formatTime(hariAwal?.toDate())} - ${formatDate(hariAwal?.toDate())}'),
                        buildDetailRow('Waktu Tiba',
                            '${formatTime(hariTiba?.toDate())} - ${formatDate(hariTiba?.toDate())}'),
                      ]),
                      Divider(thickness: 2, height: 40),
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: getPassengerList(widget.history['id']),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData || snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('Tidak ada penumpang ditemukan'));
                          }

                          List<Map<String, dynamic>> passengerList =
                              snapshot.data!;
                          return buildSection([
                            buildDetailRow('Jumlah Penumpang',
                                passengerList.length.toString()),
                            ...passengerList.map((passenger) {
                              int index = passengerList.indexOf(passenger) + 1;
                              return buildDetailRow('Nama Penumpang $index',
                                  '${passenger['nama']} - NIK: ${passenger['NIK']}');
                            }).toList(),
                          ]);
                        },
                      ),
                      Divider(thickness: 2, height: 40),
                      buildSection([
                        buildDetailRow(
                            'Total Harga', 'Rp. ${widget.history['harga']}'),
                      ]),
                      Divider(thickness: 2, height: 40),
                      Center(
                        child: FutureBuilder<String>(
                          future: qrCodeUrl,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }
                            return Image.network(snapshot.data!);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Tombol batalkan pesanan hanya muncul jika status transaksi adalah AKTIF
      bottomNavigationBar: status == 'AKTIF'
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: cancelOrder,
                child: const Text('Batalkan Pesanan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.red, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
            )
          : null,
    );
  }

  // Fungsi untuk mengambil daftar penumpang dari Firebase berdasarkan ID riwayat
  Future<List<Map<String, dynamic>>> getPassengerList(String historyId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('riwayat')
          .doc(historyId)
          .collection('penumpang')
          .get();

      return querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();
    } catch (e) {
      print("Error fetching passengers: $e");
      return [];
    }
  }

  // Widget untuk membangun bagian dengan children di dalam kolom
  Widget buildSection(List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  // Widget untuk membangun baris detail dengan label dan nilai
  Widget buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk membangun baris status dengan label dan nilai berwarna sesuai status
  Widget buildStatusRow(String label, String status) {
    Color statusColor;
    switch (status) {
      case 'AKTIF':
        statusColor = Colors.blue;
        break;
      case 'SELESAI':
        statusColor = Colors.green;
        break;
      case 'DIBATALKAN':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
