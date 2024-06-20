// artikel.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArtikelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Daftar artikel yang berisi judul dan URL gambar
    final List<Map<String, String>> articles = [
      {
        'title': 'Catat, Ini Daftar Kereta Api Tambahan Keberangkatan Juni-JuIi 2024',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Kereta_api_penumpang_kelas_eksekutif..jpg/1200px-Kereta_api_penumpang_kelas_eksekutif..jpg',
      },
      {
        'title': 'TickeTrax Beri Diskon Tiket Kereta Api 10% Periode Liburan, Cek Informasinya',
        'image': 'https://image.popbela.com/content-images/post/20221227/6-3bbb4156e86b30dfbab35676fdccce75.png?width=1600&format=webp&w=1600',
      },
      {
        'title': 'Fitur Baru TickeTrax!!',
        'image': 'https://upload.wikimedia.org/wikipedia/commons/b/bc/KRL_Commuter_Line_dan_kereta_api_jarak_jauh_di_Stasiun_Jatinegara..jpg',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF797EF6),
      ),
      // Menampilkan daftar artikel menggunakan ListView.builder
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              // Navigasi ke halaman detail artikel saat artikel diklik
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(
                    title: article['title']!,
                    imageUrl: article['image']!,
                  ),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4.0,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                    child: Image.network(
                      article['image']!,
                      fit: BoxFit.cover,
                      height: 200.0,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      article['title']!,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ArticleDetailPage extends StatelessWidget {
  final String title;
  final String imageUrl;

  const ArticleDetailPage({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: Color(0xFF797EF6),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250.0,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Konten artikel ada di sini...',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
