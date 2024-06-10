// screens/profilepage.dart
import 'package:flutter/material.dart';
import '../data/user_data.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = LoggedInUser.user;
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
                  margin: const EdgeInsets.only(
                      left: 2.0, right: 2.0, top: 16.0, bottom: 16.0),
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
                              user?.profileImage ?? 'assets/default_profile.png',
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
                                  user?.name ?? 'Guest',
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
                                    // Aksi saat tombol "Edit Profile" ditekan
                                  },
                                  style: ButtonStyle(
                                    textStyle: MaterialStateProperty.all<TextStyle>(
                                      TextStyle(
                                        color: Color(0xFF797EF6),
                                        fontSize: 16,
                                      ),
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF797EF6)),
                                    padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                          vertical: 12, horizontal: 24),
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color:Color(0xFF797EF6), width: 1),
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
                    // Aksi saat menu "Ganti Password" ditekan
                  },
                ),
                MenuCard(
                  icon: Icons.help,
                  text: 'FAQ',
                  onTap: () {
                    // Aksi saat menu "FAQ" ditekan
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
                    // Aksi saat menu "Profil Developer" ditekan
                  },
                ),
                MenuCard(
                  icon: Icons.logout,
                  text: 'Log Out',
                  onTap: () {
                    // Aksi saat menu "Log Out" ditekan
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
        onTap: onTap,
      ),
    );
  }
}
