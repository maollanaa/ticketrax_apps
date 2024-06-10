// data/user_data.dart
class User {
  final String name;
  final String phoneNumber;
  final String email;
  final DateTime birthDate;
  final String gender;
  final String password;
  final String profileImage;

  User({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.password,
    required this.profileImage
  });
}

List<User> users = [
  User(
    name: 'tester',
    phoneNumber: '085739234449',
    email: '123',
    birthDate: DateTime(2004, 1, 12),
    gender: 'Female',
    password: '12345678',
    profileImage: ''
  ),
  User(
    name: 'Rakha Maulana',
    phoneNumber: '085161907446',
    email: 'rakhamaul04@gmail.com',
    birthDate: DateTime(2004, 5, 22),
    gender: 'Male',
    password: 'rakhapass',
    profileImage: 'assets/rakha.jpg'
  ),
  User(
    name: 'Anggi Trisna Sari',
    phoneNumber: '085739234449',
    email: 'atrisnasari@gmail.com',
    birthDate: DateTime(2004, 1, 12),
    gender: 'Female',
    password: 'anggipass',
    profileImage: 'assets/anggi.jpg'
  ),
  // Add more users here as needed
];

class LoggedInUser {
  static User? user;
}