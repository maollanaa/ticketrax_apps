// screens/profile_developer.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/developer_data.dart';
import 'package:intl/intl.dart';

class ProfileDeveloperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Developer'),
      ),
      body: ListView.builder(
        itemCount: developers.length, // Jumlah item dalam daftar developer
        itemBuilder: (context, index) {
          final dev = developers[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(dev.profileImage), // Gambar profil developer
                        radius: 30,
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dev.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(dev.email), // Email developer
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('NPM: ${dev.npm}'), // NPM developer
                  Text('Tanggal Lahir: ${DateFormat('dd MMM yyyy').format(dev.birthDate)}'), // Tanggal lahir developer
                  Text('Zodiak: ${dev.zodiac}'), // Zodiak developer
                  Text('Usia: ${dev.age}'), // Usia developer
                  Row(
                    children: [
                      Icon(Icons.link),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _launchURL(dev.linkedIn), // Buka profil LinkedIn
                        child: Text(
                          'LinkedIn',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.code),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () => _launchURL(dev.gitHub), // Buka profil GitHub
                        child: Text(
                          'GitHub',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Fungsi untuk membuka URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Tidak bisa membuka $url';
    }
  }
}
