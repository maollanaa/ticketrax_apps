// screens/historypage.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/history_db.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'historyp_detail.dart';
import '../../auth/logged_in_user.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Riwayat Pesanan',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorColor: Color(0xFF797EF6), // Warna indikator tab
            labelColor: Color(0xFF797EF6), // Warna teks tab yang dipilih
            unselectedLabelColor: Colors.grey, // Warna teks tab yang tidak dipilih
            tabs: [
              Tab(text: 'Semua'),
              Tab(text: 'Aktif'),
              Tab(text: 'Selesai'),
              Tab(text: 'Dibatalkan'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            HistoryTab(status: 'Semua'),
            HistoryTab(status: 'Aktif'),
            HistoryTab(status: 'Selesai'),
            HistoryTab(status: 'Dibatalkan'),
          ],
        ),
      ),
    );
  }
}

class HistoryTab extends StatelessWidget {
  final String status;

  const HistoryTab({required this.status, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String userEmail = LoggedInUser().email;

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: HistoryDB().getHistoryList(userEmail),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada riwayat ditemukan'));
        }

        List<Map<String, dynamic>> historyList = snapshot.data!;
        if (status != 'Semua') {
          historyList = historyList
              .where((item) => item['status'] == status.toUpperCase())
              .toList();
        }

        return ListView.builder(
          itemCount: historyList.length,
          itemBuilder: (context, index) {
            return HistoryCard(history: historyList[index]);
          },
        );
      },
    );
  }
}

class HistoryCard extends StatelessWidget {
  final Map<String, dynamic> history;

  const HistoryCard({required this.history, Key? key}) : super(key: key);

  // Fungsi untuk memformat tanggal menjadi bentuk yang lebih mudah dibaca
  String formatDate(DateTime? dateTime) {
    if (dateTime == null) return '-';
    final dayName = DateFormat('EEEE', 'id_ID').format(dateTime);
    final day = dateTime.day;
    final month = DateFormat('MMMM', 'id_ID').format(dateTime);
    final year = dateTime.year;
    return '$dayName, $day $month $year';
  }

  // Fungsi untuk memformat waktu menjadi bentuk yang lebih mudah dibaca
  String formatTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return DateFormat('HH:mm', 'id_ID').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final Timestamp? waktuTransaksi = history['waktu'];
    final Timestamp? hariAwal = history['hari_awal'];
    final Timestamp? hariTiba = history['hari_tiba'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HistoryDetailPage(history: history),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(12.0),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Menampilkan nama perjalanan dan status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    history['nama'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: _getSoftStatusColor(history['status']),
                      border: Border.all(color: _getStatusColor(history['status'])),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      history['status'],
                      style: TextStyle(fontSize: 12, color: _getStatusColor(history['status'])),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              // Menampilkan stasiun awal dan akhir
              Row(
                children: [
                  Expanded(
                    child: Text(
                      history['stasiun_awal'],
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(Icons.arrow_right_alt),
                  Expanded(
                    child: Text(
                      history['stasiun_akhir'],
                      style: TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              // Menampilkan tanggal dan waktu perjalanan
              Text(
                '${formatDate(hariAwal?.toDate())}, ${formatTime(hariAwal?.toDate())} - ${formatTime(hariTiba?.toDate())}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 8),
              // Menampilkan harga perjalanan
              Text(
                'Rp. ${history['harga']}',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk mendapatkan warna status berdasarkan status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'AKTIF':
        return Colors.blue;
      case 'SELESAI':
        return Colors.green;
      case 'DIBATALKAN':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Fungsi untuk mendapatkan warna latar belakang status berdasarkan status
  Color _getSoftStatusColor(String status) {
    switch (status) {
      case 'AKTIF':
        return Colors.blue.shade100;
      case 'SELESAI':
        return Colors.green.shade100;
      case 'DIBATALKAN':
        return Colors.red.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
}
