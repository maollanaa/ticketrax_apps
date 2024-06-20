// screens/orderp_showstasiun.dart
import 'package:flutter/material.dart';
import '../../data/stasiun_db.dart';

class ShowStasiunAwal extends StatefulWidget {
  @override
  _ShowStasiunAwalState createState() => _ShowStasiunAwalState();
}

class _ShowStasiunAwalState extends State<ShowStasiunAwal> {
  final StasiunDB _stasiunDB = StasiunDB();
  late Future<List<Map<String, dynamic>>> _stasiunFuture;
  List<Map<String, dynamic>> _filteredStasiunList = [];
  TextEditingController _searchController = TextEditingController();

  // Daftar stasiun statis untuk ditampilkan
  final List<Map<String, dynamic>> _staticStasiunList = [
    {'nama': 'JAKARTA', 'kota': 'JAKARTA'},
    {'nama': 'BANDUNG', 'kota': 'BANDUNG'},
    {'nama': 'YOGYAKARTA', 'kota': 'YOGYAKARTA'},
    {'nama': 'SEMARANG', 'kota': 'SEMARANG'},
    {'nama': 'SURABAYA', 'kota': 'SURABAYA'},
  ];

  @override
  void initState() {
    super.initState();
    _stasiunFuture = _stasiunDB.getStasiunList().then((list) {
      return _staticStasiunList + List<Map<String, dynamic>>.from(list);
    });
    _searchController.addListener(_onSearchChanged);
  }

  // Fungsi untuk menangani perubahan pencarian
  void _onSearchChanged() {
    _stasiunFuture.then((list) {
      setState(() {
        _filteredStasiunList = list
            .where((stasiun) =>
                stasiun['nama']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                stasiun['kota']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari Stasiun Awal...',
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            final stasiunList = _searchController.text.isEmpty
                ? snapshot.data!
                : _filteredStasiunList;
            if (stasiunList.isEmpty) {
              return Center(child: Text('Stasiun tidak ditemukan'));
            }
            return ListView.builder(
              itemCount: stasiunList.length,
              itemBuilder: (context, index) {
                final stasiun = stasiunList[index];
                return ListTile(
                  title: Text(stasiun['nama']),
                  subtitle: Text(stasiun['kota']),
                  onTap: () {
                    Navigator.pop(context, stasiun);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ShowStasiunTujuan extends StatefulWidget {
  @override
  _ShowStasiunTujuanState createState() => _ShowStasiunTujuanState();
}

class _ShowStasiunTujuanState extends State<ShowStasiunTujuan> {
  final StasiunDB _stasiunDB = StasiunDB();
  late Future<List<Map<String, dynamic>>> _stasiunFuture;
  List<Map<String, dynamic>> _filteredStasiunList = [];
  TextEditingController _searchController = TextEditingController();

  // Daftar stasiun statis untuk ditampilkan
  final List<Map<String, dynamic>> _staticStasiunList = [
    {'nama': 'JAKARTA', 'kota': 'JAKARTA'},
    {'nama': 'BANDUNG', 'kota': 'BANDUNG'},
    {'nama': 'YOGYAKARTA', 'kota': 'YOGYAKARTA'},
    {'nama': 'SEMARANG', 'kota': 'SEMARANG'},
    {'nama': 'SURABAYA', 'kota': 'SURABAYA'},
  ];

  @override
  void initState() {
    super.initState();
    _stasiunFuture = _stasiunDB.getStasiunList().then((list) {
      return _staticStasiunList + List<Map<String, dynamic>>.from(list);
    });
    _searchController.addListener(_onSearchChanged);
  }

  // Fungsi untuk menangani perubahan pencarian
  void _onSearchChanged() {
    _stasiunFuture.then((list) {
      setState(() {
        _filteredStasiunList = list
            .where((stasiun) =>
                stasiun['nama']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()) ||
                stasiun['kota']
                    .toLowerCase()
                    .contains(_searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Cari Stasiun Tujuan...',
            border: InputBorder.none,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            final stasiunList = _searchController.text.isEmpty
                ? snapshot.data!
                : _filteredStasiunList;
            if (stasiunList.isEmpty) {
              return Center(child: Text('Stasiun tidak ditemukan'));
            }
            return ListView.builder(
              itemCount: stasiunList.length,
              itemBuilder: (context, index) {
                final stasiun = stasiunList[index];
                return ListTile(
                  title: Text(stasiun['nama']),
                  subtitle: Text(stasiun['kota']),
                  onTap: () {
                    Navigator.pop(context, stasiun);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
