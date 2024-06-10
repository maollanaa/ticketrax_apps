// login_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'register_page.dart';
import '../screens/homepage.dart';
import '../data/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


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
                labelStyle: TextStyle(fontFamily: 'Poppins'),
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
                    height: 100,
                  ),
                  SizedBox(height: 24),
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
                        fontFamily: 'Poppins',
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

  void _login() {
    bool userFound = false;
    for (var user in users) {
      if (user.email == _email && user.password == _password) {
        LoggedInUser.user = user; // Simpan informasi pengguna yang sedang login
        userFound = true;
        break;
      }
    }
    if (userFound) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => inApps()),
      );
    } else {
      setState(() {
        _loginFailed = true;
      });
    }
  }
}

// pake firebase
// // login_page.dart
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'register_page.dart';
// import '../ui/homepage.dart';
// import '../data/users_db.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';


// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   bool _obscureText = true;
//   final _formKey = GlobalKey<FormState>();
//   String _email = '';
//   String _password = '';
//   bool _loginFailed = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           return buildMobileLayout();
//         },
//       ),
//     );
//   }

//   Widget buildMobileLayout() {
//     return Center(
//       child: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Theme(
//             data: Theme.of(context).copyWith(
//               inputDecorationTheme: InputDecorationTheme(
//                 labelStyle: TextStyle(fontFamily: 'Poppins'),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Color(0xFF797EF6)),
//                 ),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Image.asset(
//                     'assets/logo.png',
//                     height: 100,
//                   ),
//                   SizedBox(height: 24),
//                   TextFormField(
//                     cursorColor: Color(0xFF797EF6),
//                     decoration: InputDecoration(
//                       labelText: 'Email',
//                       errorText: _loginFailed ? 'Email atau password salah' : null,
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Email tidak boleh kosong';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _email = value;
//                         _loginFailed = false;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 16),
//                   TextFormField(
//                     cursorColor: Color(0xFF797EF6),
//                     obscureText: _obscureText,
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscureText ? Icons.visibility : Icons.visibility_off,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             _obscureText = !_obscureText;
//                           });
//                         },
//                       ),
//                       errorText: _loginFailed ? 'Email atau password salah' : null,
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Password tidak boleh kosong';
//                       }
//                       if (value.length < 8) {
//                         return 'Password minimal 8 karakter';
//                       }
//                       return null;
//                     },
//                     onChanged: (value) {
//                       setState(() {
//                         _password = value;
//                         _loginFailed = false;
//                       });
//                     },
//                   ),
//                   SizedBox(height: 24),
//                   ElevatedButton(
//                     onPressed: () {
//                       if (_formKey.currentState!.validate()) {
//                         _formKey.currentState!.save();
//                         _login();
//                       }
//                     },
//                     child: Text(
//                       'Masuk',
//                       style: TextStyle(
//                         fontFamily: 'Poppins',
//                         color: Colors.white, // Warna teks
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(vertical: 20), // Atur tinggi tombol di sini
//                       backgroundColor: Color(0xFF797EF6), // Warna tombol
//                     ),
//                   ),
//                   SizedBox(height: 12),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => RegisterPage()),
//                       );
//                     },
//                     child: Text(
//                       'Belum memiliki akun? Daftar',
//                       style: TextStyle(color: Color(0xFF797EF6)),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _login() async {
//   try {
//     final querySnapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: _email)
//         .where('password', isEqualTo: _password)
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       final userData = querySnapshot.docs.first.data();
//       LoggedInUser.instance.setUserData(userData);
      
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => inApps()),
//       );
//     } else {
//       setState(() {
//         _loginFailed = true;
//       });
//     }
//   } catch (e) {
//     print("Error during login: $e");
//     setState(() {
//       _loginFailed = true;
//     });
//   }
// }

// }