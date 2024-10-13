import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan informasi dummy untuk username dan total poin
    String username = "Muhammad Naufal"; // Ganti dengan data nyata
    int totalPoints = 100; // Ganti dengan data nyata

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.bold, // Mengatur teks Home menjadi bold
          ),
        ),
        backgroundColor: Colors.green, // Mengatur warna AppBar
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green.shade200, Colors.green.shade100],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Gambar profil
              CircleAvatar(
                radius: 70, // Mengatur radius gambar profil menjadi lebih besar
                backgroundImage: AssetImage(
                    'assets/image/profile.jpg'), // Ganti dengan gambar profil Anda
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
                  fontWeight:
                      FontWeight.bold, // Mengatur teks Total Poin menjadi bold
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              // Tombol kembali
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Home'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  backgroundColor: Colors.green, // Mengatur warna tombol
                  foregroundColor: Colors.white, // Mengatur warna teks tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
