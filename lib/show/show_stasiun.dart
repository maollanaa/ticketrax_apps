// showstasiun.dart
import 'package:flutter/material.dart';
import '../data/stasiun_db.dart';

class ShowStasiun extends StatefulWidget {
  @override
  _ShowStasiunState createState() => _ShowStasiunState();
}

class _ShowStasiunState extends State<ShowStasiun> {
  final StasiunDB _stasiunDB = StasiunDB();
  late Future<List<Map<String, dynamic>>> _stasiunFuture;

  @override
  void initState() {
    super.initState();
    _stasiunFuture = _stasiunDB.getStasiunList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Stasiun'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _stasiunFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            final stasiunList = snapshot.data!;
            return ListView.builder(
              itemCount: stasiunList.length,
              itemBuilder: (context, index) {
                final stasiun = stasiunList[index];
                return ListTile(
                  title: Text(stasiun['nama']),
                  subtitle: Text(stasiun['kota']),
                );
              },
            );
          }
        },
      ),
    );
  }
}