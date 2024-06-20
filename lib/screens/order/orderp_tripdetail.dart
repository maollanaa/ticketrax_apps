// screens/orderp_tripdetail.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../auth/logged_in_user.dart';
import 'orderp_tripconfirm.dart';

class OrderTripDetail extends StatelessWidget {
  final Map<String, dynamic> trip;
  final String passengerCount;
  final String selectedDate;

  const OrderTripDetail({
    Key? key,
    required this.trip,
    required this.passengerCount,
    required this.selectedDate,
  }) : super(key: key);

  // Fungsi untuk memformat tanggal menjadi format yang diinginkan
  String formatDate(String date) {
    DateTime dateTime = DateFormat('EEEE, dd MMMM yyyy', 'en_US').parse(date);
    return DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final int harga = trip['harga'];
    final int totalHarga = harga * int.parse(passengerCount);
    final List<PassengerForm> passengerForms = List.generate(
      int.parse(passengerCount),
      (index) => PassengerForm(index: index + 1),
    );

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
          'Detail Perjalanan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Kartu yang menampilkan detail perjalanan
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 10),
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
                          SizedBox(height: 4),
                          Text(
                            formatDate(selectedDate),
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150, // Atur lebar sesuai kebutuhan
                                    child: Text(
                                      trip['stasiun_awal'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    trip['berangkat'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(Icons.arrow_forward, color: Colors.black),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 150, // Atur lebar sesuai kebutuhan
                                    child: Text(
                                      trip['stasiun_akhir'],
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    trip['tiba'],
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Harga Tiket:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(harga)}',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Penumpang:',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '$passengerCount',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Total: Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(totalHarga)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ...passengerForms,
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                List<Map<String, String>> passengers =
                    passengerForms.map((form) {
                  return {
                    'name': form.nameController.text,
                    'ktp': form.ktpController.text,
                  };
                }).toList();

                // Navigasi ke halaman konfirmasi pemesanan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderTripConfirm(
                      trip: trip,
                      passengerCount: int.parse(passengerCount),
                      passengers: passengers,
                      selectedDate: selectedDate,
                    ),
                  ),
                );
              },
              child: Text('Konfirmasi Pemesanan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF797EF6),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PassengerForm extends StatefulWidget {
  final int index;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();

  PassengerForm({Key? key, required this.index}) : super(key: key);

  @override
  _PassengerFormState createState() => _PassengerFormState();
}

class _PassengerFormState extends State<PassengerForm> {
  bool _isAutoFill = false;
  final loggedInUser = LoggedInUser();

  @override
  void initState() {
    super.initState();
    if (widget.index == 1) {
      widget.nameController.text = loggedInUser.fullName;
      _isAutoFill = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
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
              'Penumpang ${widget.index}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.index == 1)
              SwitchListTile(
                title: Text(
                  'Isi dengan nama pengguna',
                  style: TextStyle(
                      fontSize: 14), // Ubah ukuran font sesuai kebutuhan
                ),
                value: _isAutoFill,
                onChanged: (bool value) {
                  setState(() {
                    _isAutoFill = value;
                    if (value) {
                      widget.nameController.text = loggedInUser.fullName;
                    } else {
                      widget.nameController.clear();
                    }
                  });
                },
              ),
            SizedBox(height: 10),
            TextField(
              controller: widget.nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              enabled: !(widget.index == 1 && _isAutoFill),
            ),
            SizedBox(height: 10),
            TextField(
              controller: widget.ktpController,
              decoration: InputDecoration(
                labelText: 'NIK',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

