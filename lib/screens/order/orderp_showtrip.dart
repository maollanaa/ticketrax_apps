// screens/orderp_showtrip.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/trip_db.dart';
import '../../data/kereta_db.dart';
import 'orderp_tripdetail.dart';

class OrderShowTrip extends StatefulWidget {
  final String origin;
  final String destination;
  final String date;
  final String passengerCount;

  const OrderShowTrip({
    Key? key,
    required this.origin,
    required this.destination,
    required this.date,
    required this.passengerCount,
  }) : super(key: key);

  @override
  _OrderShowTripState createState() => _OrderShowTripState();
}

class _OrderShowTripState extends State<OrderShowTrip> {
  final TripDB _tripDB = TripDB();
  final KeretaDB _keretaDB = KeretaDB();
  late Future<List<Map<String, dynamic>>> _tripFuture;
  late DateTime _selectedDate;
  late DateTime _today;

  @override
  void initState() {
    super.initState();
    _today = DateTime.now();
    try {
      // Parsing tanggal dari format string ke DateTime
      _selectedDate =
          DateFormat('EEEE, dd MMMM yyyy', 'id_ID').parse(widget.date);
    } catch (e) {
      print('Error parsing date: $e');
      _selectedDate = _today; // Jika parsing gagal, gunakan tanggal hari ini
    }
    _tripFuture = _fetchTrips();
  }

  // Fungsi untuk mengambil daftar trip berdasarkan filter
  Future<List<Map<String, dynamic>>> _fetchTrips() async {
    try {
      List<Map<String, dynamic>> keretaList =
          await _keretaDB.getFilteredKeretaList(
        widget.origin,
        widget.destination,
      );

      if (keretaList.isEmpty) {
        return [];
      }

      List<String> keretaNames =
          keretaList.map((kereta) => kereta['nama'] as String).toList();

      List<Map<String, dynamic>> trips = await _tripDB.getTripList();
      String selectedDay =
          DateFormat('EEEE', 'id_ID').format(_selectedDate).toUpperCase();

      return trips
          .where((trip) =>
              trip['hari'] == selectedDay && keretaNames.contains(trip['nama']))
          .map((trip) {
        final kereta = keretaList.firstWhere((k) => k['nama'] == trip['nama']);
        return {
          ...trip,
          'stasiun_awal': kereta['stasiun_awal'],
          'stasiun_akhir': kereta['stasiun_akhir'],
          'harga': int.parse(kereta['harga']), // Pastikan 'harga' adalah integer
        };
      }).toList();
    } catch (e) {
      print('Error fetching trips: $e');
      return [];
    }
  }

  // Fungsi untuk memperbarui tanggal yang dipilih
  void _updateDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _tripFuture = _fetchTrips();
    });
  }

  // Fungsi untuk mengatur tanggal ke hari berikutnya
  void _nextDay() {
    _updateDate(_selectedDate.add(Duration(days: 1)));
  }

  // Fungsi untuk mengatur tanggal ke hari sebelumnya
  void _previousDay() {
    if (_selectedDate.isAfter(_today)) {
      _updateDate(_selectedDate.subtract(Duration(days: 1)));
    }
  }

  // Fungsi untuk navigasi ke halaman detail trip
  void _navigateToTripDetail(Map<String, dynamic> trip) {
    String formattedDate =
        DateFormat('EEEE, d MMMM yyyy').format(_selectedDate!);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrderTripDetail(
          trip: trip,
          passengerCount: widget.passengerCount,
          selectedDate: formattedDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Column(
          children: [
            Text(
              '${widget.origin.toUpperCase()} → ${widget.destination.toUpperCase()}',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              '${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(_selectedDate).toUpperCase()} | ${widget.passengerCount.toUpperCase()} DEWASA',
              style: TextStyle(fontSize: 14, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white, // Mengatur warna tombol kembali
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed:
                      _selectedDate.isAfter(_today) ? _previousDay : null,
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                  child: Text(
                    DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
                        .format(_selectedDate)
                        .toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: _nextDay,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _tripFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Tidak Ada Jadwal yang Tersedia'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final trip = snapshot.data![index];
                      final int harga = trip['harga'];
                      final int passengerCount =
                          int.parse(widget.passengerCount);
                      final int totalHarga = harga * passengerCount;

                      return InkWell(
                        onTap: () => _navigateToTripDetail(trip),
                        child: Card(
                          margin: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF797EF6)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trip['nama'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              150, // Atur lebar sesuai kebutuhan
                                          child: Text(
                                            trip['stasiun_awal'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text('${trip['berangkat']}'),
                                      ],
                                    ),
                                    Icon(Icons.arrow_forward,
                                        color: Colors.black),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              150, // Atur lebar sesuai kebutuhan
                                          child: Text(
                                            trip['stasiun_akhir'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Text('${trip['tiba']}'),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(totalHarga)}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
