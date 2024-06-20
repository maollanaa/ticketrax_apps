import 'package:flutter/material.dart';

// Halaman FAQ untuk aplikasi TickeTrax
class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TickeTrax FAQ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            FAQTile(
              title: 'Bagaimana cara memesan tiket kereta api?',
              content: 'Untuk memesan tiket kereta api, buka aplikasi kami, pilih tujuan dan tanggal perjalanan Anda, pilih kereta yang sesuai, isi informasi penumpang, dan lakukan pembayaran.',
            ),
            FAQTile(
              title: 'Metode pembayaran apa saja yang tersedia?',
              content: 'Kami menerima berbagai metode pembayaran termasuk QRIS, transfer bank, dan pembayaran melalui e-wallet.',
            ),
            FAQTile(
              title: 'Apakah saya bisa membatalkan tiket yang sudah dipesan?',
              content: 'Ya, Anda dapat membatalkan tiket yang sudah dipesan melalui aplikasi kami. Harap diperhatikan bahwa mungkin ada biaya pembatalan sesuai dengan kebijakan perusahaan kereta api.',
            ),
            FAQTile(
              title: 'Apakah anak-anak membutuhkan tiket?',
              content: 'Anak-anak di atas usia 3 tahun memerlukan tiket untuk perjalanan kereta api. Anak-anak di bawah usia 3 tahun dapat bepergian tanpa tiket asalkan duduk di pangkuan orang tua atau wali.',
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk menampilkan tile FAQ dengan kemampuan ekspansi
class FAQTile extends StatelessWidget {
  final String title;
  final String content;

  FAQTile({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF797EF6)),
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: TextStyle(
            color: Color(0xFF797EF6),
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              content,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
