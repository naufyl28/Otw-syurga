import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/login_screen.dart' as login; // Alias untuk login_screen.dart
import 'screens/register_screen.dart'
    as register; // Alias untuk register_screen.dart
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Define initial route
      initialRoute: '/',
      routes: {
        '/': (context) =>
            const login.LoginScreen(), // Menggunakan alias 'login'
        '/register': (context) =>
            const register.RegisterScreen(), // Menggunakan alias 'register'
        '/home': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}
