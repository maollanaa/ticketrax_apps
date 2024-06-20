// screens/orderp_tripconfirm.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'orderp_trippaymentcomplete.dart';
import '../../auth/logged_in_user.dart';

class OrderTripConfirm extends StatefulWidget {
  final Map<String, dynamic> trip;
  final int passengerCount;
  final List<Map<String, String>> passengers;
  final String selectedDate;

  const OrderTripConfirm({
    Key? key,
    required this.trip,
    required this.passengerCount,
    required this.passengers,
    required this.selectedDate,
  }) : super(key: key);

  @override
  _OrderTripConfirmState createState() => _OrderTripConfirmState();
}

class _OrderTripConfirmState extends State<OrderTripConfirm> {
  String? selectedPaymentMethod;
  String? selectedEWallet;
  String? selectedBank;
  String? eWalletNumber;
  String? bankAccountNumber;

  // Fungsi untuk memformat tanggal dan waktu menjadi format yang diinginkan
  String formatDateTime(String date, String time) {
    DateTime dateTime = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'en_US')
        .parse('$date $time');
    return DateFormat('HH:mm - EEEE, dd MMMM yyyy', 'id_ID').format(dateTime);
  }

  // Fungsi yang dipanggil saat tombol pembayaran ditekan
  void _onPaymentButtonPressed() async {
    String errorMessage = '';

    if (selectedPaymentMethod == null) {
      errorMessage = 'Pilih metode pembayaran';
    } else if (selectedPaymentMethod == 'E-Wallet') {
      if (selectedEWallet == null) {
        errorMessage = 'Pilih jenis E-Wallet';
      } else if (eWalletNumber == null || eWalletNumber!.isEmpty) {
        errorMessage = 'Isi nomor E-Wallet';
      }
    } else if (selectedPaymentMethod == 'Transfer Bank') {
      if (selectedBank == null) {
        errorMessage = 'Pilih bank';
      } else if (bankAccountNumber == null || bankAccountNumber!.isEmpty) {
        errorMessage = 'Isi nomor rekening';
      }
    }

    if (errorMessage.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(errorMessage),
      ));
      return;
    }

    // Simpan pemesanan ke Firestore
    await _saveBookingToFirestore();

    // Navigasi ke halaman pembayaran selesai
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TripPaymentComplete()),
    );
  }

  // Fungsi untuk menyimpan pemesanan ke Firestore
  Future<void> _saveBookingToFirestore() async {
    try {
      final user = LoggedInUser().email; // Asumsikan Anda memiliki email pengguna di kelas LoggedInUser
      final totalHarga = widget.trip['harga'] * widget.passengerCount;
      final transactionTime = DateTime.now();
      final waktuBerangkat = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'en_US')
          .parse('${widget.selectedDate} ${widget.trip['berangkat']}');
      final waktuTiba = DateFormat('EEEE, dd MMMM yyyy HH:mm', 'en_US')
          .parse('${widget.selectedDate} ${widget.trip['tiba']}');

      final riwayatRef = FirebaseFirestore.instance.collection('riwayat');
      final newRiwayatRef = riwayatRef.doc();

      await newRiwayatRef.set({
        'waktu': transactionTime,
        'status': 'AKTIF',
        'nama': widget.trip['nama'],
        'stasiun_awal': widget.trip['stasiun_awal'],
        'stasiun_akhir': widget.trip['stasiun_akhir'],
        'hari_awal': waktuBerangkat,
        'hari_tiba': waktuTiba,
        'harga': NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(totalHarga),
        'email': user,
      });

      final penumpangRef = newRiwayatRef.collection('penumpang');
      for (var passenger in widget.passengers) {
        await penumpangRef.add({
          'nama': passenger['name'],
          'NIK': passenger['ktp'],
        });
      }

    } catch (e) {
      print("Error saving booking to Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final int harga = widget.trip['harga'];
    final int totalHarga = harga * widget.passengerCount;

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
          'Konfirmasi Pemesanan',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTripDetailsCard(totalHarga),
            SizedBox(height: 20),
            _buildPaymentMethodCard(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _onPaymentButtonPressed,
          child: Text('Lakukan Pembayaran'),
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
    );
  }

  // Widget untuk menampilkan kartu detail perjalanan
  Widget _buildTripDetailsCard(int totalHarga) {
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
              'Detail Perjalanan',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${widget.trip['nama']}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stasiun Awal:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150, // Sesuaikan lebar sesuai kebutuhan
                      child: Text(
                        widget.trip['stasiun_awal'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_forward, color: Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stasiun Akhir:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 150, // Sesuaikan lebar sesuai kebutuhan
                      child: Text(
                        widget.trip['stasiun_akhir'],
                        style: TextStyle(
                          fontSize: 16,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Waktu Berangkat: ${formatDateTime(widget.selectedDate, widget.trip['berangkat'])}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Waktu Tiba: ${formatDateTime(widget.selectedDate, widget.trip['tiba'])}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Divider(
              color: Colors.grey,
              thickness: 1,
            ),
            SizedBox(height: 10),
            Text(
              'Jumlah Penumpang: ${widget.passengerCount}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ...widget.passengers.asMap().entries.map((entry) {
              int index = entry.key + 1;
              Map<String, String> passenger = entry.value;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Penumpang $index:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${passenger['name']} - NIK ${passenger['ktp']}',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ],
              );
            }).toList(),
            SizedBox(height: 10),
            Text(
              'Total Harga: Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(totalHarga)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan kartu metode pembayaran
  Widget _buildPaymentMethodCard() {
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
              'Metode Pembayaran',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              value: selectedPaymentMethod,
              hint: Text('Pilih Metode Pembayaran'),
              items: ['QRIS', 'E-Wallet', 'Transfer Bank']
                  .map((method) => DropdownMenuItem<String>(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                  selectedEWallet = null;
                  selectedBank = null;
                  eWalletNumber = null;
                  bankAccountNumber = null;
                });
              },
            ),
            if (selectedPaymentMethod == 'E-Wallet') ...[
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedEWallet,
                hint: Text('Pilih Jenis E-Wallet'),
                items: ['DANA', 'GOPAY', 'LinkAja', 'Shopee Pay', 'OVO']
                    .map((eWallet) => DropdownMenuItem<String>(
                          value: eWallet,
                          child: Text(eWallet),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedEWallet = value;
                  });
                },
              ),
              if (selectedEWallet != null) ...[
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nomor E-Wallet',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      eWalletNumber = value;
                    });
                  },
                ),
              ],
            ],
            if (selectedPaymentMethod == 'Transfer Bank') ...[
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                value: selectedBank,
                hint: Text('Pilih Bank'),
                items: [
                  'BRI',
                  'BCA',
                  'Mandiri',
                  'BNI',
                  'CIMB Niaga',
                  'Danamon'
                ].map((bank) => DropdownMenuItem<String>(
                      value: bank,
                      child: Text(bank),
                    )).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedBank = value;
                  });
                },
              ),
              if (selectedBank != null) ...[
                SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Nomor Rekening',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      bankAccountNumber = value;
                    });
                  },
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
