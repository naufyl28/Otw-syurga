import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String _currentTime = ""; // Inisialisasi dengan string kosong
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _updateCurrentTime();
  }

  void _updateCurrentTime() {
    Future.delayed(const Duration(seconds: 1), () {
      if (!_isDisposed) {
        setState(() {
          // Mengubah format untuk menampilkan jam, menit, dan detik
          _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
        });
        _updateCurrentTime();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Jam sekarang
            Text(
              _currentTime.isEmpty
                  ? "Current Time"
                  : _currentTime, // Menampilkan teks default jika belum ada waktu
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),

            // Daftar waktu salat
            const Text(
              'Waktu Salat:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: const [
                Text('Subuh: 05:00'),
                Text('Dhuhur: 12:00'),
                Text('Ashar: 15:30'),
                Text('Maghrib: 18:00'),
                Text('Isya: 19:30'),
              ],
            ),
            const SizedBox(height: 40),

            // Tombol navigasi
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              child: const Text('Go to Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/settings');
              },
              child: const Text('Go to Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
