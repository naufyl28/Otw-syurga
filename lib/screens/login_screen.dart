import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;
  final TextEditingController _usernameController =
      TextEditingController(); // Treat as Email
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _errorMessage = null; // Clear previous error message
    });

    // Validasi jika email atau password kosong
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Mohon isi email dan password';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _usernameController.text, // Treat the username as email
        password: _passwordController.text,
      );
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        // Tampilkan pesan error khusus jika email atau password salah
        if (e.code == 'user-not-found' ||
            e.code == 'wrong-password' ||
            e.code == 'invalid-email') {
          _errorMessage = 'Email atau Password Anda salah';
        } else {
          _errorMessage = 'Email atau Password Anda salah.';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Email atau Password Anda salah';
      });
    }
  }

  Future<void> _forgotPassword() async {
    String email = _usernameController.text;
    if (email.isEmpty) {
      setState(() {
        _errorMessage = 'Mohon isi email untuk reset password';
      });
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      setState(() {
        _errorMessage = 'Link reset password telah dikirim ke email Anda';
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = 'Terjadi kesalahan: ${e.message}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 4, 191, 116),
              Colors.green.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text(
                  'Salat adalah jembatan antara kita dan Allah',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
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
                    Image.asset(
                      'assets/image/logomasjid.png',
                      height: 100,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OTWSYURGA',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Field Email
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Email', // Use 'Email'
                      ),
                    ),
                    // Field Password
                    TextField(
                      controller: _passwordController,
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
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: _login, // Call the login function
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 4, 231, 140),
                          foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                          minimumSize: const Size(200, 50),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                    ),
                    // Error message display
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    // Forgot Password link
                    TextButton(
                      onPressed: _forgotPassword,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Belum mempunyai akun? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          TextSpan(
                            text: 'Daftar disini',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 13, 197, 47),
                              fontSize: 16,
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
