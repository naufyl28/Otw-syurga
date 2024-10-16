import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; 
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
                  borderRadius: BorderRadius.circular(
                      12.0), 
                ),
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, 
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
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 4, 231, 140),
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
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                            text: 'Belum mempunyai akun? ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black, 
                              fontSize:16,
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
