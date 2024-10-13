import 'package:flutter/material.dart';
import 'dart:async'; // Import untuk Timer
import 'package:intl/intl.dart'; // Import untuk format tanggal

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Waktu salat statis untuk sementara
  Map<String, String> prayerTimes = {
    "Shubuh": "04:30 AM",
    "Dhuzuhur": "12:00 PM",
    "Ashar": "03:30 PM",
    "Maghrib": "06:00 PM",
    "Isya": "07:30 PM",
  };

  // Menyimpan status salat (apakah sudah dilakukan atau belum)
  Map<String, bool> prayerStatus = {
    "Shubuh": false,
    "Dhuzuhur": false,
    "Ashar": false,
    "Maghrib": false,
    "Isya": false,
  };

  // Variabel untuk menyimpan waktu dan tanggal saat ini
  late String _currentTime;
  late String _currentDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime =
        _formatCurrentTime(DateTime.now()); // Inisialisasi waktu saat ini
    _currentDate = _formatCurrentDate(DateTime.now()); // Inisialisasi tanggal
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
    _timer.cancel(); // Hentikan timer saat widget di-dispose
    super.dispose();
  }

  // Fungsi untuk format waktu ke jam:menit:detik
  String _formatCurrentTime(DateTime time) {
    return "${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}";
  }

  // Fungsi untuk format tanggal ke d MMMM yyyy
  String _formatCurrentDate(DateTime date) {
    return DateFormat('d MMMM yyyy').format(date);
  }

  // Fungsi untuk toggle status salat
  void _togglePrayerStatus(String prayer) {
    setState(() {
      prayerStatus[prayer] = !prayerStatus[prayer]!;
    });
  }

  // Menghitung total poin berdasarkan status salat
  int _calculatePoints() {
    int points = 0;
    for (var status in prayerStatus.values) {
      if (status) {
        points += 20; // Tambah 20 poin untuk setiap salat yang dicentang
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Stack(
          children: [
            Center(
              child: Container(
                margin:
                    const EdgeInsets.only(top: 100), // Menambahkan margin atas
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white, // Warna background putih
                        borderRadius: BorderRadius.circular(
                            12.0), // Membuat kotak sudut melengkung
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Menyesuaikan isinya
                        children: [
                          // Menampilkan gambar logo
                          Image.asset(
                            'assets/image/logomasjid.png',
                            height: 100, // Atur tinggi gambar sesuai kebutuhan
                          ),
                          const SizedBox(height: 20), // Margin di bawah logo
                          // Menampilkan waktu saat ini
                          Text(
                            _currentTime, // Tampilkan waktu saat ini
                            style: const TextStyle(
                              fontSize: 48, // Ukuran besar untuk jam
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Menampilkan tanggal sekarang
                          Text(
                            _currentDate, // Tampilkan tanggal saat ini
                            style: const TextStyle(
                              fontSize: 18, // Ukuran lebih kecil untuk tanggal
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Menampilkan lokasi di tengah
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
                          // Menampilkan waktu salat
                          for (var entry in prayerTimes.entries)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        onPressed: () => _togglePrayerStatus(entry
                                            .key), // Toggle status saat di klik
                                      ),
                                      Text(
                                        entry.key,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: prayerStatus[entry.key]!
                                              ? Colors.grey
                                              : Colors.black, // Mengubah warna
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    entry.value,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: prayerStatus[entry.key]!
                                          ? Colors.grey
                                          : Colors.black, // Mengubah warna
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          const SizedBox(height: 20),
                          // Menampilkan total poin
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                              color: Colors
                                  .blue[100], // Warna latar belakang biru muda
                              borderRadius: BorderRadius.circular(
                                  8.0), // Sudut melengkung
                            ),
                            child: Text(
                              'Poin anda hari ini: ${_calculatePoints()} poin',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Warna teks biru
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
            // Menambahkan logo pengaturan dan profil di pojok kanan atas
            Positioned(
              left: 16, // Posisikan logo pengaturan di kiri
              top: 40, // Menurunkan posisi logo pengaturan
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.pushNamed(
                      context, '/settings'); // Ganti dengan route yang sesuai
                },
              ),
            ),
            Positioned(
              right: 16, // Posisikan logo profil di kanan
              top: 40, // Menurunkan posisi logo profil
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
