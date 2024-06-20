import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ticketrax_apps/splash_n_welcome.dart';
import 'firebase_options.dart';
import 'auth/login_page.dart';
import 'splash_n_welcome.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

// Fungsi utama yang dijalankan pertama kali saat aplikasi dimulai
void main() async {
  // Memastikan binding widget telah terinisialisasi
  WidgetsFlutterBinding.ensureInitialized();
  
  // Menginisialisasi Firebase dengan konfigurasi platform saat ini
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Menginisialisasi data format tanggal lokal untuk bahasa Indonesia
  await initializeDateFormatting('id_ID', null);
  
  // Menjalankan aplikasi TicketTrax
  runApp(TicketTrax());
}

// Kelas utama aplikasi TicketTrax
class TicketTrax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Judul aplikasi
      title: 'TICKETRAX',
      
      // Menonaktifkan banner debug
      debugShowCheckedModeBanner: false,
      
      // Menerapkan tema aplikasi dengan Google Fonts Poppins
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      
      // Menetapkan halaman awal aplikasi ke halaman splash
      home: Splash(),
    );
  }
}
