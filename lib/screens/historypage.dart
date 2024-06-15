// screens/historypage.dart
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat'),
          bottom: const TabBar(
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
            Center(child: Text('Semua Riwayat')),
            Center(child: Text('Riwayat Aktif')),
            Center(child: Text('Riwayat Selesai')),
            Center(child: Text('Riwayat Dibatalkan')),
          ],
        ),
      ),
    );
  }
}
