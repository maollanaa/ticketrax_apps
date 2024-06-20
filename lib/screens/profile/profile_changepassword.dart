// screens/change_password.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/logged_in_user.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller teks
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  Future<void> _changePassword() async {
    // Fungsi untuk mengganti password pengguna
    if (_formKey.currentState!.validate()) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: LoggedInUser().email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs.first;
          String currentPassword = userDoc['password'];

          if (currentPassword != _oldPasswordController.text) {
            // Memeriksa jika password lama salah
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password lama salah')),
            );
            return;
          }

          if (_newPasswordController.text != _confirmPasswordController.text) {
            // Memeriksa jika password baru tidak cocok
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Password baru tidak cocok')),
            );
            return;
          }

          await userDoc.reference.update({
            'password': _newPasswordController.text,
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password berhasil diperbarui')),
          );

          _oldPasswordController.clear();
          _newPasswordController.clear();
          _confirmPasswordController.clear();
        } else {
          // Jika pengguna tidak ditemukan
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Pengguna tidak ditemukan')),
          );
        }
      } catch (e) {
        // Jika terjadi kesalahan saat memperbarui password
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui password: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Membangun UI untuk halaman ganti password
    return Scaffold(
      appBar: AppBar(
        title: Text('Ganti Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _oldPasswordController,
                obscureText: true,
                cursorColor: Color(0xFF797EF6),
                decoration: InputDecoration(
                  labelText: 'Password Lama',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan password lama anda';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _newPasswordController,
                obscureText: true,
                cursorColor: Color(0xFF797EF6),
                decoration: InputDecoration(
                  labelText: 'Password Baru',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan password baru anda';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: true,
                cursorColor: Color(0xFF797EF6),
                decoration: InputDecoration(
                  labelText: 'Konfirmasi Password Baru',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Konfirmasi password baru anda';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _changePassword,
                child: Text(
                  'Ganti Password',
                  style: TextStyle(
                    color: Colors.white, // Warna teks
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20), // Tinggi tombol
                  backgroundColor: Color(0xFF797EF6), // Warna tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Menghapus controller teks saat widget dihancurkan
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
