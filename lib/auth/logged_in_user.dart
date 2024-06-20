// logged_in_user.dart
class LoggedInUser {
  static final LoggedInUser _instance = LoggedInUser._internal();

  String fullName = '';
  String email = '';
  String password = '';
  String phoneNum = '';
  String profileImage = '';
  String gender = '';
  DateTime birthDate = DateTime.now();

  factory LoggedInUser() {
    return _instance;
  }

  LoggedInUser._internal();
}
