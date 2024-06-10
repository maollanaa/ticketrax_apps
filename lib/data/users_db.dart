// pake firebase
// import 'package:cloud_firestore/cloud_firestore.dart';

// class User {
//   String fullName;
//   String email;
//   String password;
//   String gender;
//   String birthDate;
//   String phoneNum;
//   String profileImage;

//   User({
//     required this.fullName,
//     required this.email,
//     required this.password,
//     required this.gender,
//     required this.birthDate,
//     required this.phoneNum,
//     required this.profileImage,
//   });

//   factory User.fromDocument(DocumentSnapshot doc) {
//     Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//     return User(
//       fullName: data['fullName'],
//       email: data['email'],
//       password: data['password'],
//       gender: data['gender'],
//       birthDate: data['birthDate'],
//       phoneNum: data['phoneNum'],
//       profileImage: data['profileImage'],
//     );
//   }
// }

// class UsersDB {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   User? loggedInUser;

//   Future<void> setLoggedInUser(String email, String password) async {
//     try {
//       QuerySnapshot result = await _firestore
//           .collection('users')
//           .where('email', isEqualTo: email)
//           .where('password', isEqualTo: password)
//           .limit(1)
//           .get();

//       if (result.docs.isNotEmpty) {
//         loggedInUser = User.fromDocument(result.docs.first);
//       } else {
//         loggedInUser = null;
//       }
//     } catch (e) {
//       print('Error setting logged in user: $e');
//       loggedInUser = null;
//     }
//   }
// }

// final UsersDB usersDB = UsersDB();

// class LoggedInUser {
//   static final LoggedInUser _instance = LoggedInUser._internal();
//   static LoggedInUser get instance => _instance;

//   Map<String, dynamic>? _userData;

//   LoggedInUser._internal();

//   void setUserData(Map<String, dynamic> userData) {
//     _userData = userData;
//   }

//   Map<String, dynamic>? get userData => _userData;
// }
