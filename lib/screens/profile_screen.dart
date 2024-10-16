import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String username = "Muhammad Naufal";
    int totalPoints = 100;

    List<Map<String, dynamic>> previousPoints = [
      {'date': '13 Oktober 2024', 'points': 40},
      {'date': '12 Oktober 2024', 'points': 30},
      {'date': '11 Oktober 2024', 'points': 30},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 7, 216, 133),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 7, 216, 133),
              Colors.green.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Card(
            elevation: 8, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16), // Sudut bulat pada Card
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0), // Padding di dalam Card
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Gambar profil
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('assets/image/profile.jpg'),
                  ),
                  const SizedBox(height: 20),
                  // Username
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Total poin perolehan
                  Text(
                    'Total Poin: $totalPoints',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20), 
                  // List hari-hari sebelumnya
                  Expanded(
                    child: ListView.builder(
                      itemCount: previousPoints.length,
                      itemBuilder: (context, index) {
                        final data = previousPoints[index];
                        return Card(
                          elevation: 2, // Bayangan untuk Card hari
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                10), // Sudut bulat pada Card
                          ),
                          margin: const EdgeInsets.only(
                              bottom: 10), // Jarak antar card
                          child: ListTile(
                            leading: const Icon(Icons.calendar_today),
                            title: Text(data['date']),
                            subtitle: Text('Poin: ${data['points']}'),
                          ),
                        );
                      },
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
}
