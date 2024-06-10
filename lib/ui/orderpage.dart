// apps/orderpage.dart
import 'package:flutter/material.dart';
import 'orderschedule_set.dart'; // Import halaman tujuan

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> popularDestinations = [
      {
        'name': 'JAKARTA',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Jakarta_Skyline_Part_2.jpg/800px-Jakarta_Skyline_Part_2.jpg'
      },
      {
        'name': 'BANDUNG',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Bandung_View_dari_Gedung_Wisma_HSBC_Asia_Afrika_4.jpg/1200px-Bandung_View_dari_Gedung_Wisma_HSBC_Asia_Afrika_4.jpg'
      },
      {
        'name': 'YOGYAKARTA',
        'image':
            'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Yogyakarta_Indonesia_Tugu-Yogyakarta-02.jpg/1200px-Yogyakarta_Indonesia_Tugu-Yogyakarta-02.jpg'
      },
      {
        'name': 'SEMARANG',
        'image':
            'https://static.promediateknologi.id/crop/0x0:0x0/0x0/webp/photo/p2/01/2023/07/09/f496a13e-7684-4399-bd8a-0da160aa054b-3141960377.jpg'
      },
      {
        'name': 'SURABAYA',
        'image':
            'https://lh5.googleusercontent.com/proxy/MZb9xjHMKIUvGipsqtY_N9hkaLl-Qce1Kau5jo6w6Kf6PxAoUjHMsBJncmVZe0N3DGkHpUQJIsJheztFH8tGJy-6tywNXPnk_LwUSAVuVFvnLqVoAw'
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              'Tujuan Populer',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: popularDestinations.length,
              itemBuilder: (context, index) {
                final destination = popularDestinations[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OrderScheduleSet(destination: destination['name']),
                      ),
                    );
                  },
                  child: Container(
                    height: 200.0, // Set maximum height for the card
                    child: Card(
                      margin: EdgeInsets.only(bottom: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 4.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            12.0), // Gunakan border radius yang sama dengan card
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.network(
                                destination['image']!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8.0,
                              right: 8.0,
                              child: Container(
                                color: Colors.black54,
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  destination['name']!,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OrderScheduleSet()),
          );
        },
        child: Icon(Icons.add, color: Colors.white), // Set icon color to white
        backgroundColor: Color(0xFF797EF6),
        foregroundColor: Colors.white, // Set button color to white
        shape: CircleBorder(), // Make button round
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
