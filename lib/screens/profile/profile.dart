// screens/profilepage.dart
import 'package:flutter/material.dart';
import 'package:ticketrax_apps/screens/profile/profile_edit.dart';
import '../../auth/logged_in_user.dart';
import 'package:ticketrax_apps/screens/profile/profile_changepassword.dart';
import 'package:ticketrax_apps/screens/profile/profile_faqTT.dart';
import 'package:ticketrax_apps/splash_n_welcome.dart';
import 'package:ticketrax_apps/screens/profile/profile_developer.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loggedInUser = LoggedInUser(); // Mendapatkan instance dari LoggedInUser

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF797EF6), Colors.purple],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
          Positioned(
            top: 100,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Card(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      color: Color(0xFF797EF6),
                      width: 0.2,
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(
                              loggedInUser.profileImage.isNotEmpty
                                  ? loggedInUser.profileImage
                                  : 'assets/default_profile.png', // Gambar default jika tidak ada gambar profil
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 24, 20, 28),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  loggedInUser.fullName.isNotEmpty
                                      ? loggedInUser.fullName
                                      : 'Guest', // Nama default jika tidak ada nama pengguna
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 2),
                                const Text(
                                  'TicketTrax User',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfileEdit()),
                                    ); // Navigasi ke halaman edit profil
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF797EF6)),
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: Color(0xFF797EF6), width: 1),
                                      ),
                                    ),
                                  ),
                                  child: const Text('Edit Profile'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.lock,
                  text: 'Ganti Password',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangePassword()),
                    ); // Navigasi ke halaman ganti password
                  },
                ),
                MenuCard(
                  icon: Icons.help,
                  text: 'FAQ',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FAQPage()),
                    ); // Navigasi ke halaman FAQ
                  },
                ),
                MenuCard(
                  icon: Icons.info,
                  text: 'Tentang Apps',
                  onTap: () {
                    // Aksi saat menu "Tentang Apps" ditekan
                  },
                ),
                MenuCard(
                  icon: Icons.person,
                  text: 'Profil Developer',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDeveloperScreen()),
                    ); // Navigasi ke halaman profil developer
                  },
                ),
                MenuCard(
                  icon: Icons.logout,
                  text: 'Log Out',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Logout berhasil',
                          style: TextStyle(color: Color(0xFF797EF6)), // warna teks
                        ),
                        duration: Duration(seconds: 2), // durasi tampilan snackbar
                        backgroundColor: Colors.white, // warna background snackbar
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Splash()),
                    ); // Navigasi ke halaman splash setelah logout
                  },
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Kelas MenuCard digunakan untuk menampilkan kartu menu di halaman profil
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final Color? iconColor;
  final Color? textColor;

  const MenuCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.iconColor,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.black,
          width: 0.2,
        ),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor ?? Color(0xFF868686)),
        title: Text(
          text,
          style: TextStyle(color: textColor ?? Colors.black),
        ),
        onTap: onTap, // Aksi saat kartu menu ditekan
      ),
    );
  }
}
