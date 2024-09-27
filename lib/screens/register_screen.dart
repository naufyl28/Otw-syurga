import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background hijau di luar kotak putih
      body: Container(
        color: Colors.green, // Warna background hijau
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Warna background putih
                  borderRadius: BorderRadius.circular(
                      12.0), // Membuat sudut kotak melengkung
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Menyesuaikan ukuran kolom sesuai isinya
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo di bagian atas
                    Column(
                      children: [
                        // Menampilkan gambar logo
                        Image.asset(
                          'assets/image/logomasjid.png',
                          height: 100, // Atur tinggi gambar sesuai kebutuhan
                        ),
                        const SizedBox(height: 20),
                        // Menambahkan teks "Register"
                        const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    // Form register
                    TextField(
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    // Menambahkan margin atas dan bawah pada tombol register
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Warna tombol biru
                          foregroundColor:
                              Colors.white, // Warna teks tombol putih
                          minimumSize: const Size(200, 50), // Ukuran tombol
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tombol Back di kiri atas
            Positioned(
              top: 50, // Mengatur jarak dari atas agar tidak kena header
              left: 16, // Jarak dari kiri
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman login
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
