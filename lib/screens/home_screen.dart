import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Timer
import 'package:intl/intl.dart'; // Import untuk format tanggal

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, String> prayerTimes = {
    "Shubuh": "04:30 AM",
    "Dhzuhur": "12:00 PM",
    "Ashar": "03:30 PM",
    "Maghrib": "06:00 PM",
    "Isya": "07:30 PM",
  };

  Map<String, bool> prayerStatus = {
    "Shubuh": false,
    "Dhzuhur": false,
    "Ashar": false,
    "Maghrib": false,
    "Isya": false,
  };

  late String _currentTime;
  late String _currentDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = _formatCurrentTime(DateTime.now());
    _currentDate = _formatCurrentDate(DateTime.now());
    // Timer untuk update setiap detik
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = _formatCurrentTime(DateTime.now());
        _currentDate = _formatCurrentDate(DateTime.now());
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatCurrentTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  String _formatCurrentDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }

  // Fungsi untuk toggle status salat
  void _togglePrayerStatus(String prayer) {
    setState(() {
      prayerStatus[prayer] = !prayerStatus[prayer]!;
    });
  }

  // Fungsi untuk memilih ikon sesuai nama salat
  IconData _getPrayerIcon(String prayerName) {
    switch (prayerName) {
      case "Shubuh":
        return Icons.brightness_2; // Ikon bulan untuk Subuh
      case "Dhzuhur":
        return Icons.wb_sunny; // Ikon matahari untuk Dhuhur
      case "Ashar":
        return Icons.wb_twilight; // Ikon matahari terbenam untuk Ashar
      case "Maghrib":
        return Icons.nightlight_round; // Ikon bulan sabit untuk Maghrib
      case "Isya":
        return Icons.brightness_3; // Ikon bulan malam untuk Isya
      default:
        return Icons.access_time; // Default ikon untuk waktu
    }
  }

  // Fungsi untuk menghitung poin
  int _calculatePoints() {
    int points = 0;
    for (var status in prayerStatus.values) {
      if (status) {
        points += 20; // 20 poin per salat yang dilakukan
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade200,
              const Color.fromARGB(255, 7, 216, 133),
            ],
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                margin: const EdgeInsets.only(top: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Menampilkan gambar logo
                          Image.asset(
                            'assets/image/logomasjid.png',
                            height: 100, // Ukuran logo
                          ),
                          const SizedBox(height: 20),
                          Text(
                            _currentTime, // Waktu sekarang
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _currentDate, // Tanggal sekarang
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.location_on, // Ikon lokasi
                                color: Colors.red,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Balikpapan', // Nama kota
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          // Menampilkan waktu salat dengan ikon
                          for (var entry in prayerTimes.entries)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          prayerStatus[entry.key]!
                                              ? Icons.check_circle
                                              : Icons.circle,
                                          color: prayerStatus[entry.key]!
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                        onPressed: () => _togglePrayerStatus(entry.key),
                                      ),
                                      Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: prayerStatus[entry.key]!
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        _getPrayerIcon(entry.key), // Ikon sesuai waktu salat
                                        color: Colors.grey, // Warna ikon
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: prayerStatus[entry.key]!
                                              ? Colors.grey
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Poin berdasarkan salat yang sudah dilakukan
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 69, 236, 141),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Text(
                              'Poin anda hari ini: ${_calculatePoints()} poin',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tombol setting di kiri atas
            Positioned(
              left: 16,
              top: 40,
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ),
            // Tombol profile di kanan atas
            Positioned(
              right: 16,
              top: 40,
              child: IconButton(
                icon: const Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
