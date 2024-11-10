import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState(); // Changed here
}

class HomeScreenState extends State<HomeScreen> {
  // Changed here
  Map<String, String> prayerTimes = {};
  Map<String, bool> prayerStatus = {
    'Shubuh': false,
    'Dhzuhur': false,
    'Ashar': false,
    'Maghrib': false,
    'Isya': false,
  };

  late String _currentTime;
  late String _currentDate;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = _formatCurrentTime(DateTime.now());
    _currentDate = _formatCurrentDate(DateTime.now());

    // Memanggil API untuk mendapatkan waktu salat
    _fetchPrayerTimes();

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

  Future<void> _fetchPrayerTimes() async {
    String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String url = 'https://api.myquran.com/v2/sholat/jadwal/2308/$date';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        prayerTimes = {
          'Shubuh': data['data']['jadwal']['subuh'],
          'Dhzuhur': data['data']['jadwal']['dzuhur'],
          'Ashar': data['data']['jadwal']['ashar'],
          'Maghrib': data['data']['jadwal']['maghrib'],
          'Isya': data['data']['jadwal']['isya'],
        };
      });
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  void _togglePrayerStatus(String prayer) {
    setState(() {
      prayerStatus[prayer] = !prayerStatus[prayer]!;
    });
  }

  IconData _getPrayerIcon(String prayerName) {
    switch (prayerName) {
      case 'Shubuh':
        return Icons.brightness_2;
      case 'Dhzuhur':
        return Icons.wb_sunny;
      case 'Ashar':
        return Icons.wb_twilight;
      case 'Maghrib':
        return Icons.nightlight_round;
      case 'Isya':
        return Icons.brightness_3;
      default:
        return Icons.access_time;
    }
  }

  int _calculatePoints() {
    int points = 0;
    for (var status in prayerStatus.values) {
      if (status) {
        points += 20;
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Check if the content exceeds the screen height
          bool isScrollable = constraints.maxHeight < 600;

          return Container(
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
                // Only enable SingleChildScrollView when needed
                if (isScrollable)
                  SingleChildScrollView(
                    child: _buildContent(),
                  )
                else
                  _buildContent(),
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
                Positioned(
                  right: 16,
                  top: 40,
                  child: IconButton(
                    icon: const Icon(
                      Icons.person,
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
          );
        },
      ),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 100),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/image/logomasjid.png',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _currentTime,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    _currentDate,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      SizedBox(width: 5),
                      Text(
                        'Balikpapan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
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
                                _getPrayerIcon(entry.key),
                                color: Colors.grey,
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
    );
  }
}
