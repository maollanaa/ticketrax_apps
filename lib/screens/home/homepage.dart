// homepage.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../order/orderpage.dart';
import '../history/historypage.dart';
import '../profile/profile.dart';
import 'artikel.dart'; 
import 'dart:async';
import '../../auth/logged_in_user.dart';
import '../order/orderp_setschedule.dart';

// Fungsi utama yang menjalankan aplikasi
void main() {
  runApp(const inApps());
}

// Widget utama aplikasi yang bersifat stateful
class inApps extends StatefulWidget {
  const inApps({Key? key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

// State dari widget utama yang mengatur halaman-halaman dalam aplikasi
class HomePageState extends State<inApps> {
  int idx = 0; // Indeks halaman yang sedang ditampilkan

  static final List<Widget> halaman = [
    const HomePage(),
    const OrderPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  // Fungsi yang dipanggil ketika item di bottom navigation bar ditekan
  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Scaffold(
        body: halaman[idx], // Menampilkan halaman sesuai dengan indeks
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: idx,
          selectedItemColor: const Color(0xFF797EF6),
          unselectedItemColor: Colors.grey,
          onTap: onItemTap, // Memanggil fungsi ketika item ditekan
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Pesan Tiket'),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

// Widget untuk halaman utama aplikasi
class HomePage extends StatelessWidget {
  const HomePage();

  // Fungsi untuk mendapatkan salam sesuai dengan waktu
  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Selamat Pagi,';
    } else if (hour < 15) {
      return 'Selamat Siang,';
    } else if (hour < 18) {
      return 'Selamat Sore,';
    } else {
      return 'Selamat Malam,';
    }
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = LoggedInUser();

    final List<Map<String, String>> popularDestinations = [
      {
        'name': 'JAKARTA',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Jakarta_Skyline_Part_2.jpg/800px-Jakarta_Skyline_Part_2.jpg'
      },
      {
        'name': 'BANDUNG',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Bandung_View_dari_Gedung_Wisma_HSBC_Asia_Afrika_4.jpg/1200px-Bandung_View_dari_Gedung_Wisma_HSBC_Asia_Afrika_4.jpg'
      },
      {
        'name': 'YOGYAKARTA',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Yogyakarta_Indonesia_Tugu-Yogyakarta-02.jpg/1200px-Yogyakarta_Indonesia_Tugu-Yogyakarta-02.jpg'
      },
      {
        'name': 'SEMARANG',
        'image': 'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/07/09/f496a13e-7684-4399-bd8a-0da160aa054b-3141960377.jpg'
      },
      {
        'name': 'SURABAYA',
        'image': 'https://lh5.googleusercontent.com/proxy/MZb9xjHMKIUvGipsqtY_N9hkaLl-Qce1Kau5jo6w6Kf6PxAoUjHMsBJncmVZe0N3DGkHpUQJIsJheztFH8tGJy-6tywNXPnk_LwUSAVuVFvnLqVoAw'
      },
    ];

    final List<Map<String, String>> articles = [
      {'title': 'Catat, Ini Daftar Kereta', 'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Kereta_api_penumpang_kelas_eksekutif..jpg/640px-Kereta_api_penumpang_kelas_eksekutif..jpg'},
      {'title': 'Beri Diskon Tiket Kereta Api 10%', 'image': 'https://image.popbela.com/content-images/post/20221227/6-3bbb4156e86b30dfbab35676fdccce75.png?width=1600&format=webp&w=1600'},
    ];

    final List<String> slideImages = [
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Kereta_api_penumpang_kelas_eksekutif..jpg/1200px-Kereta_api_penumpang_kelas_eksekutif..jpg',
      'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Kereta_api_penumpang_kelas_eksekutif..jpg/640px-Kereta_api_penumpang_kelas_eksekutif..jpg',
      'https://cdn.antaranews.com/cache/1200x800/2022/09/27/KA-Penumpang-Kaligung-relasi-Semarang-Poncol-Cirebon-Prujakan-tengah-melintasi-pesisir-pantai-utara-di-wilayah-Plabuan-Kabupaten-Batang-Provinsi-Jawa-Tengah.jpeg',
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Menampilkan kartu dengan salam dan nama pengguna
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    gradient: LinearGradient(
                      colors: [Color(0xFF797EF6), Colors.purple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getGreeting(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              loggedInUser.fullName.toUpperCase(),
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.notifications, color: Colors.white),
                              onPressed: () {
                                // Tambahkan aksi notifikasi di sini
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.settings, color: Colors.white),
                              onPressed: () {
                                // Tambahkan aksi pengaturan di sini
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Menampilkan kartu gambar untuk slide
          Positioned(
            top: 120.0,
            left: 12.0,
            right: 12.0,
            child: Container(
              height: 200,
              child: PageView(
                children: slideImages.map((url) => slideCard(url)).toList(),
              ),
            ),
          ),
          // Menampilkan kartu tujuan populer
          Positioned(
            top: 340.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tujuan Populer',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: popularDestinations.length,
                      itemBuilder: (context, index) {
                        final destination = popularDestinations[index];
                        return popularDestinationCard(
                          context,
                          destination['name']!,
                          destination['image']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Menampilkan kartu artikel terbaru
          Positioned(
            top: 560.0,
            left: 16.0,
            right: 16.0,
            child: Container(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Artikel Terbaru',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ArtikelPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Lihat Lainnya',
                          style: GoogleFonts.poppins(
                            color: Color(0xFF797EF6),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return articleCard(
                          context,
                          article['title']!,
                          article['image']!,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk kartu gambar dalam slide
  Widget slideCard(String imageUrl) {
    return Center(
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Container(
          width: 420,
          height: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // Widget untuk kartu destinasi populer
  Widget popularDestinationCard(BuildContext context, String city, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0), // Sesuaikan jarak antar kartu di sini
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderScheduleSet(destination: city),
            ),
          );
        },
        child: Container(
          height: 200.0,
          width: 280, // Set lebar kartu untuk scrolling horizontal
          child: Card(
            margin: EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 8.0,
                    right: 8.0,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        city,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  // Widget untuk kartu artikel
  Widget articleCard(BuildContext context, String title, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0), // Sesuaikan jarak antar kartu di sini
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailPage(title: title, imageUrl: imageUrl),
            ),
          );
        },
        child: Container(
          height: 200.0,
          width: 280, // Set lebar kartu untuk scrolling horizontal
          child: Card(
            margin: EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 8.0,
                    left: 8.0,
                    child: Container(
                      color: Colors.black54,
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
