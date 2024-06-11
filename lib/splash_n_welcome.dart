import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'auth/login_page.dart';
import 'auth/register_page.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Timer untuk menunggu selama 3 detik sebelum pindah ke halaman Welcome
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade, // Atur jenis transisi di sini
          child: Welcome(),
        ),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue, // Warna pertama
              Colors.purple, // Warna kedua
              Colors.red, // Warna ketiga
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            width: 240.0, // Lebar yang diinginkan
            height: 240.0, // Tinggi yang diinginkan
          ),
        ),
      ),
    );
  }
}

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Spacer(), // Spacer untuk mendorong konten ke bawah
          Center(
            child: Text(
              'Welcome Page',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                  },
                  child: Text(
                    'Masuk',
                    style: TextStyle(
                      color: Colors.white, // Warna teks
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20), // Atur tinggi tombol di sini
                    backgroundColor: Color(0xFF797EF6), // Warna tombol
                  ),
                ),
                SizedBox(height: 8.0), // Jarak antara dua tombol
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterPage()),
                        );
                  },
                  child: Text(
                    'Daftar',
                    style: TextStyle(
                      color: Color(0xFF797EF6), // Warna teks
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 20), // Atur tinggi tombol di sini
                    side: BorderSide(color: Color(0xFF797EF6)), // Warna border
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Splash(),
  ));
}
