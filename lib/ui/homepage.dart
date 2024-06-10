// apps/homepage.dart
import 'package:flutter/material.dart';
import 'orderpage.dart';
import 'historypage.dart';
import 'profile.dart';
import '../data/user_data.dart';
import '../show/show_stasiun.dart';

void main() {
  runApp(const inApps());
}

class inApps extends StatefulWidget {
  const inApps({Key? key}) : super(key: key);
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<inApps> {
  int idx = 0; // indeks yang aktif

  static final List<Widget> halaman = [
    HomePage(user: LoggedInUser.user), // Mengirimkan LoggedInUser.user ke HomePage
    const OrderPage(),
    const HistoryPage(),
    const ProfilePage(),
  ];

  void onItemTap(int index) {
    setState(() {
      idx = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: halaman[idx],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed, // Ensure fixed type
          currentIndex: idx,
          selectedItemColor: const Color(0xFF797EF6),
          unselectedItemColor:
              Colors.grey, // Warna abu-abu untuk item yang tidak dipilih
          onTap: onItemTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
            BottomNavigationBarItem(
                icon: Icon(Icons.train), label: 'Pesan Tiket'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'Riwayat'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final User? user; // Menerima objek User

  const HomePage({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hai, ${user?.name ?? ''}', // Menampilkan nama pengguna jika ada
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShowStasiun()),
                );
              },
              child: Text('Lihat Daftar Stasiun'),
            ),
          ],
        ),
      ),
    );
  }
}

// pake firebase
// import 'package:flutter/material.dart';
// import 'orderpage.dart';
// import 'historypage.dart';
// import 'profile.dart';
// import '../data/users_db.dart';
// import '../show/show_stasiun.dart';

// void main() {
//   runApp(const inApps());
// }

// class inApps extends StatefulWidget {
//   const inApps({Key? key}) : super(key: key);

//   @override
//   HomePageState createState() {
//     return HomePageState();
//   }
// }

// class HomePageState extends State<inApps> {
//   int idx = 0; // indeks yang aktif
//   User? loggedInUser;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   Future<void> _loadUser() async {
//     await usersDB.setLoggedInUser('user@example.com', 'password123'); // Replace with actual login credentials
//     setState(() {
//       loggedInUser = usersDB.loggedInUser;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: loggedInUser == null 
//         ? Scaffold(
//             body: Center(child: CircularProgressIndicator()), // Show loading indicator while user is loading
//           ) 
//         : Scaffold(
//             body: IndexedStack(
//               index: idx,
//               children: [
//                 HomePage(user: loggedInUser), // Pass the logged-in user to HomePage
//                 const OrderPage(),
//                 const HistoryPage(),
//                 const ProfilePage(),
//               ],
//             ),
//             bottomNavigationBar: BottomNavigationBar(
//               type: BottomNavigationBarType.fixed, // Ensure fixed type
//               currentIndex: idx,
//               selectedItemColor: const Color(0xFF797EF6),
//               unselectedItemColor: Colors.grey, // Warna abu-abu untuk item yang tidak dipilih
//               onTap: (index) {
//                 setState(() {
//                   idx = index;
//                 });
//               },
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
//                 BottomNavigationBarItem(icon: Icon(Icons.train), label: 'Pesan Tiket'),
//                 BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
//                 BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
//               ],
//             ),
//           ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   final User? user; // Menerima objek User

//   const HomePage({Key? key, this.user}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               user != null ? 'Hai, ${user!.fullName}' : 'Hai, Pengguna', // Menampilkan nama pengguna jika ada
//               style: const TextStyle(fontSize: 20),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => ShowStasiun()),
//                 );
//               },
//               child: const Text('Lihat Daftar Stasiun'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
