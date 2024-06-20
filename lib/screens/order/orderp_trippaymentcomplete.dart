// screens/orderp_trippaymentcomplete.dart
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ticketrax_apps/screens/history/historypage.dart';

class TripPaymentComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF797EF6), Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Lottie animation untuk menampilkan animasi sukses
                  Lottie.asset(
                    'assets/success.json', // Pastikan untuk menyertakan animasi Lottie untuk sukses
                    height: 150,
                    repeat: false,
                  ),
                  SizedBox(height: 20),
                  // Teks yang menampilkan pesan sukses pembayaran
                  Text(
                    'Pembayaran Berhasil!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  // Tombol untuk pergi ke halaman riwayat
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoryPage()),
                      );
                    },
                    child: Text('Pergi ke Halaman Riwayat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF797EF6),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Tombol untuk kembali ke halaman beranda
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, (route) => route.isFirst);
                    },
                    child: Text('Kembali ke Beranda'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color(0xFF797EF6),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

