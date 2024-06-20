// register_page.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import '../screens/home/homepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'logged_in_user.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final _formKey = GlobalKey<FormState>();
  String _fullName = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _phoneNum = '';
  String _gender = 'Laki-laki';
  DateTime _birthDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        labelText: 'Nama Lengkap',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nama Lengkap tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fullName = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      cursorColor: Color(0xFF797EF6),
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Email tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      cursorColor: Color(0xFF797EF6),
                      decoration: InputDecoration(
                        labelText: 'Nomor Telepon',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Nomor Telepon tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _phoneNum = value!;
                      },
                    ),
                    SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: InputDecoration(
                        labelText: 'Jenis Kelamin',
                      ),
                      items: <String>['Laki-laki', 'Perempuan']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _gender = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      cursorColor: Color(0xFF797EF6),
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
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
                        _password = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      cursorColor: Color(0xFF797EF6),
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Konfirmasi Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Konfirmasi Password tidak boleh kosong';
                        }
                        if (value != _password) {
                          return 'Password dan Konfirmasi Password tidak cocok';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        _confirmPassword = value;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      readOnly: true,
                      cursorColor: Color(0xFF797EF6),
                      decoration: InputDecoration(
                        labelText: 'Tanggal Lahir',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () {
                            _selectDate(context);
                          },
                        ),
                      ),
                      controller: TextEditingController(
                        text: _birthDate == DateTime.now()
                            ? 'Pilih Tanggal Lahir'
                            : '${_birthDate.toLocal()}'.split(' ')[0],
                      ),
                      onTap: () {
                        _selectDate(context);
                      },
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _registerUser();
                        }
                      },
                      child: Text(
                        'Daftar',
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
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        'Sudah memiliki akun? Masuk',
                        style: TextStyle(color: Color(0xFF797EF6)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _birthDate)
      setState(() {
        _birthDate = picked;
      });
  }

  void _registerUser() async {
    // Add the user data to Firestore
    await FirebaseFirestore.instance.collection('users').add({
      'fullName': _fullName,
      'email': _email,
      'password': _password,
      'phoneNum': _phoneNum,
      'gender': _gender,
      'birthDate': _birthDate,
      'profileImage': ''

    });

    // Save user data to LoggedInUser
    final loggedInUser = LoggedInUser();
    loggedInUser.fullName = _fullName;
    loggedInUser.email = _email;
    loggedInUser.phoneNum = _phoneNum;
    loggedInUser.profileImage = ''; // Add if necessary
    loggedInUser.gender = _gender;
    loggedInUser.birthDate = _birthDate;
    

    // Navigate to the homepage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => inApps()),
    );
  }
}
