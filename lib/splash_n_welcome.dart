import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';
import 'auth/login_page.dart';
import 'auth/register_page.dart';

// Kelas Splash yang menampilkan layar splash selama 3 detik sebelum beralih ke halaman Welcome
class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Timer untuk menunggu selama 3 detik sebelum beralih ke halaman Welcome
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade, // Transisi halaman dengan efek fade
          child: Welcome(),
        ),
      );
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.purple,
              Colors.red,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo2.png',
            width: 240.0,
            height: 240.0,
          ),
        ),
      ),
    );
  }
}

// Kelas Welcome yang menampilkan halaman selamat datang dengan opsi untuk login atau register
class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.red],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(), // Spacer untuk memberikan ruang kosong di atas
            Text(
              'Selamat Datang!',
              style: TextStyle(
                fontSize: 36.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ayo Mulai Perjalananmu!',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white70,
              ),
            ),
            Spacer(), // Spacer untuk memberikan ruang kosong di bawah teks
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Navigasi ke halaman LoginPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      backgroundColor: Color(0xFF0072ff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  OutlinedButton(
                    onPressed: () {
                      // Navigasi ke halaman RegisterPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      side: BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(), // Spacer untuk memberikan ruang kosong di bawah tombol
            Text(
              '© 2024 TickeTrax',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14.0,
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
