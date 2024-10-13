import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isObscured = true; // Menyembunyikan password secara default
  bool _isConfirmObscured = true; // Menyembunyikan konfirmasi password
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordMatched = true;

  @override
  void dispose() {
    // Bersihkan controller saat tidak digunakan
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      _isPasswordMatched =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

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
                      controller: _passwordController,
                      obscureText: _isObscured, // Kontrol visibilitas password
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
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText:
                          _isConfirmObscured, // Kontrol visibilitas konfirmasi password
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        errorText: _isPasswordMatched
                            ? null
                            : 'Passwords do not match',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmObscured
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmObscured = !_isConfirmObscured;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) => _validatePassword(),
                    ),
                    const SizedBox(height: 20),
                    // Menambahkan margin atas dan bawah pada tombol register
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _validatePassword();
                          if (_isPasswordMatched) {
                            Navigator.pushNamed(context, '/home');
                          }
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
