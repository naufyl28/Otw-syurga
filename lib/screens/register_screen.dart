import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  bool _isObscured = true;
  bool _isConfirmObscured = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool _isPasswordMatched = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  void _validatePassword() {
    setState(() {
      _isPasswordMatched =
          _passwordController.text == _confirmPasswordController.text;
    });
  }

  Future<void> _register() async {
    // Check if the username is empty or exceeds 10 characters
    if (_usernameController.text.isEmpty) {
      _showSnackbar('Mohon isi username');
      return;
    } else if (_usernameController.text.length > 10) {
      _showSnackbar('Username maksimal 10 karakter');
      return;
    }

    // Check if the email is empty
    if (_emailController.text.isEmpty) {
      _showSnackbar('Mohon masukkan email Anda');
      return;
    }

    // Check if the password length is less than 6 characters
    if (_passwordController.text.length < 6) {
      _showSnackbar('Password harus terdiri dari minimal 6 karakter');
      return;
    }

    // Check if the passwords match
    if (!_isPasswordMatched) {
      _showSnackbar('Konfirmasi password tidak sama');
      return;
    }

    try {
      // Register the user
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Update the display name after registration
      try {
        await userCredential.user?.updateDisplayName(_usernameController.text);
        await userCredential.user?.reload();
      } catch (e) {
        print('Error updating display name: $e');
      }

      if (mounted) {
        // Show a success dialog
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            content: Text('Berhasil Mendaftar!'),
          ),
        );
        await Future.delayed(const Duration(seconds: 1));
        if (mounted) Navigator.pop(context); // Close dialog
        if (mounted) Navigator.pushReplacementNamed(context, '/');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showSnackbar('Email sudah terdaftar');
      } else {
        _showSnackbar('Error Registrasi: ${e.message}');
      }
    } catch (e) {
      print('Error during registration: $e');
      _showSnackbar('Terjadi kesalahan saat registrasi');
    }
  }

  void _showSnackbar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
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
        child: Stack(
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          'assets/image/logomasjid.png',
                          height: 100,
                        ),
                        const SizedBox(height: 20),
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
                    TextField(
                      controller: _usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                    ),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
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
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _isConfirmObscured,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: _register,
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
                        child: const Text('Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 16,
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
