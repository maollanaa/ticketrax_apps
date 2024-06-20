// screens/profile_edit.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/logged_in_user.dart';

class ProfileEdit extends StatefulWidget {
  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fullNameController;
  late TextEditingController _phoneNumController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: LoggedInUser().fullName);
    _phoneNumController = TextEditingController(text: LoggedInUser().phoneNum);
    _emailController = TextEditingController(text: LoggedInUser().email);
  }

  // Fungsi untuk memperbarui profil pengguna
  Future<void> _updateUserProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Mencari pengguna berdasarkan email
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: LoggedInUser().email)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Jika pengguna ditemukan, perbarui data profil
          await querySnapshot.docs.first.reference.update({
            'fullName': _fullNameController.text,
            'phoneNum': _phoneNumController.text,
          });
        } else {
          // Jika pengguna tidak ditemukan, tambahkan data pengguna baru
          await FirebaseFirestore.instance.collection('users').add({
            'fullName': _fullNameController.text,
            'phoneNum': _phoneNumController.text,
            'email': _emailController.text,
          });
        }

        // Perbarui data pengguna yang sedang masuk
        LoggedInUser().fullName = _fullNameController.text;
        LoggedInUser().phoneNum = _phoneNumController.text;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memperbarui profil: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profil'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return buildMobileLayout();
        },
      ),
    );
  }

  // Membuat tata letak untuk tampilan mobile
  Widget buildMobileLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFormField(
                  controller: _fullNameController,
                  cursorColor: Color(0xFF797EF6),
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan nama lengkap Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _phoneNumController,
                  cursorColor: Color(0xFF797EF6),
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Silakan masukkan nomor telepon Anda';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  cursorColor: Color(0xFF797EF6),
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  readOnly: true,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: Text(
                    'Simpan',
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
