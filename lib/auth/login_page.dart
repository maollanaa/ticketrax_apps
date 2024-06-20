// login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'register_page.dart';
import '../screens/home/homepage.dart';
import '../data/users_db.dart';
import 'logged_in_user.dart'; // Import the new class

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _loginFailed = false;
  final UserDB _userDB = UserDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return buildMobileLayout();
        },
      ),
    );
  }

  Widget buildMobileLayout() {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF797EF6)),
                ),
                border: OutlineInputBorder(),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 150,
                  ),
                  SizedBox(height: 28),
                  TextFormField(
                    cursorColor: Color(0xFF797EF6),
                    decoration: InputDecoration(
                      labelText: 'Email',
                      errorText:
                          _loginFailed ? 'Email atau password salah' : null,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                        _loginFailed = false;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    cursorColor: Color(0xFF797EF6),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                      errorText:
                          _loginFailed ? 'Email atau password salah' : null,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      }
                      if (value.length < 8) {
                        return 'Password minimal 8 karakter';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _password = value;
                        _loginFailed = false;
                      });
                    },
                  ),
                  SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _login();
                      }
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        color: Colors.white, // Warna teks
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: 20), // Atur tinggi tombol di sini
                      backgroundColor: Color(0xFF797EF6), // Warna tombol
                    ),
                  ),
                  SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Belum memiliki akun? Daftar',
                      style: TextStyle(color: Color(0xFF797EF6)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
  final user = await _userDB.getUserByEmailAndPassword(_email, _password);
  print('User: $user'); // Tambahkan ini untuk melihat apakah user berhasil didapat
  if (user != null) {
    // Save user data to LoggedInUser
    final loggedInUser = LoggedInUser();
    loggedInUser.fullName = user['fullName'];
    loggedInUser.email = user['email'];
    loggedInUser.password = user['password'];
    loggedInUser.phoneNum = user['phoneNum'];
    loggedInUser.profileImage = user['profileImage'];
    loggedInUser.gender = user['gender'];
    loggedInUser.birthDate = user['birthDate'].toDate();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => inApps()),
    );
  } else {
    setState(() {
      _loginFailed = true;
    });
    print('Login failed'); // Tambahkan ini untuk melihat apakah login gagal
  }
}

}
