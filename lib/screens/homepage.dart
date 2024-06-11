import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'orderpage.dart';
import 'historypage.dart';
import 'profile.dart';
import '../data/user_data.dart';
import '../show/show_stasiun.dart';
import 'dart:async';

void main() {
  runApp(const inApps());
}

class inApps extends StatefulWidget {
  const inApps({Key? key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<inApps> {
  int idx = 0; // indeks yang aktif

  static final List<Widget> halaman = [
    HomePage(
        user: LoggedInUser.user), // Mengirimkan LoggedInUser.user ke HomePage
    const OrderPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: halaman[idx],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Ensure fixed type
          currentIndex: idx,
          selectedItemColor: const Color(0xFF797EF6),
          unselectedItemColor:
              Colors.grey, // Warna abu-abu untuk item yang tidak dipilih
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.train), label: 'Pesan Tiket'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final User? user; // Menerima objek User

  const HomePage({Key? key, this.user}) : super(key: key);

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi';
    } else if (hour < 15) {
      return 'Selamat Siang';
    } else if (hour < 18) {
      return 'Selamat Sore';
    } else {
      return 'Selamat Malam';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Card yang selalu di atas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Card(
              color: const Color(0xFF797EF6),
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero, // Set border radius to zero
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                    ),
                    Text(
                      (user?.name ?? '').toUpperCase(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
