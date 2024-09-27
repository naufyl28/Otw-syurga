import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import untuk TapGestureRecognizer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Background hijau di luar kotak putih
      body: Container(
        color: Colors.green, // Warna background hijau
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Menambahkan kutipan di background hijau
              const Padding(
                padding: EdgeInsets.only(
                    bottom: 30.0), // Jarak antara kutipan dan logo
                child: Text(
                  'Salat adalah jembatan antara kita dan Allah',
                  style: TextStyle(
                    fontSize: 18, // Ukuran font diperbesar
                    fontStyle: FontStyle.italic,
                    color: Colors.white, // Warna teks kutipan putih
                  ),
                  textAlign: TextAlign.center, // Menyelaraskan teks ke tengah
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Warna background putih
                  borderRadius: BorderRadius.circular(
                      12.0), // Membuat kotak sudut melengkung
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // Mengatur agar kolom menyesuaikan isinya
                  children: [
                    // Menampilkan gambar logo
                    Image.asset(
                      'assets/image/logomasjid.png',
                      height: 100, // Atur tinggi gambar sesuai kebutuhan
                    ),
                    const SizedBox(height: 20), // Margin di bawah logo
                    // Menampilkan teks OTWSYURGA
                    const Text(
                      'OTWSYURGA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Form login
                    TextField(
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      obscureText: _isObscured,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Menambahkan margin atas dan bawah pada tombol login
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: const Size(200, 50), // Ukuran tombol
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    // Teks untuk pendaftaran dengan warna yang berbeda
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Belum mempunyai akun? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Warna teks hitam
                            ),
                          ),
                          TextSpan(
                            text: 'Daftar disini',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue, // Warna teks biru
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/register');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
