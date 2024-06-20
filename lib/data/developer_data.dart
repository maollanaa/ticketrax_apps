// data/developer_data.dart
import 'package:intl/intl.dart';

class Dev {
  final String name;
  final String npm;
  final String email;
  final DateTime birthDate;
  final String zodiac;
  final int age;
  final String linkedIn;
  final String gitHub;
  final String profileImage;

  Dev({
    required this.name,
    required this.npm,
    required this.email,
    required this.birthDate,
    required this.zodiac,
    required this.age,
    required this.linkedIn,
    required this.gitHub,
    required this.profileImage
  });

  static String calculateZodiac(DateTime birthDate) {
    int day = birthDate.day;
    int month = birthDate.month;

    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) return "Aquarius";
    if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) return "Pisces";
    if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) return "Aries";
    if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) return "Taurus";
    if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) return "Gemini";
    if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) return "Cancer";
    if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) return "Leo";
    if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) return "Virgo";
    if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) return "Libra";
    if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) return "Scorpio";
    if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) return "Sagittarius";
    if ((month == 12 && day >= 22) || (month == 1 && day <= 19)) return "Capricorn";
    return "Unknown";
  }

  static int calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}

List<Dev> developers = [
  Dev(
    name: 'Rakha Maulana',
    npm: '22082010077',
    email: 'rakharfd123@gmail.com',
    birthDate: DateTime(2004, 1, 22),
    zodiac: Dev.calculateZodiac(DateTime(2004, 1, 22)),
    age: Dev.calculateAge(DateTime(2004, 1, 22)),
    linkedIn: 'www.linkedin.com/in/rakha-maulanaa',
    gitHub: 'https://github.com/maollanaa',
    profileImage: 'assets/rakha.jpg'
  ),
  Dev(
    name: 'Anggi Trisna Sari',
    npm: '22082010078',
    email: 'anggits12@gmail.com',
    birthDate: DateTime(2004, 5, 12),
    zodiac: Dev.calculateZodiac(DateTime(2004, 5, 12)),
    age: Dev.calculateAge(DateTime(2004, 5, 12)),
    linkedIn: 'https://www.linkedin.com/in/anggitrisna',
    gitHub: 'https://github.com/anggits12',
    profileImage: 'assets/anggi.jpg'
  ),
  // Tambahkan lebih banyak pengguna di sini jika diperlukan
];
