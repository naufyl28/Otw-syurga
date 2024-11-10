import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  final User? user = FirebaseAuth.instance.currentUser;
  bool notificationsEnabled = true;
  bool isChangingPassword = false;
  bool _obscureOldPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 26, 225, 122),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator()) // Loading state
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 26, 225, 122),
                    Colors.green.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity, // Full width button
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isChangingPassword = !isChangingPassword;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.lock,
                              color: Colors.green,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Change Password',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isChangingPassword) _buildChangePasswordForm(),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: _buildNotificationSwitch(),
                  ),
                  const SizedBox(height: 40),
                  _buildLogoutButton(),
                ],
              ),
            ),
    );
  }

  // Form to change password
  Widget _buildChangePasswordForm() {
    return Column(
      children: [
        TextField(
          controller: _oldPasswordController,
          decoration: InputDecoration(
            labelText: 'Old Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureOldPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureOldPassword = !_obscureOldPassword;
                });
              },
            ),
          ),
          obscureText: _obscureOldPassword,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _newPasswordController,
          decoration: InputDecoration(
            labelText: 'New Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureNewPassword = !_obscureNewPassword;
                });
              },
            ),
          ),
          obscureText: _obscureNewPassword,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            labelText: 'Confirm New Password',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          obscureText: _obscureConfirmPassword,
        ),
        const SizedBox(height: 25),
        ElevatedButton(
          onPressed: _changePassword,
          child: const Text('Change Password'),
        ),
      ],
    );
  }

  // Change password logic
  Future<void> _changePassword() async {
    if (_newPasswordController.text == _confirmPasswordController.text) {
      try {
        final user = FirebaseAuth.instance.currentUser;
        final credentials = EmailAuthProvider.credential(
          email: user!.email!,
          password: _oldPasswordController.text,
        );

        // Reauthenticate the user
        await user.reauthenticateWithCredential(credentials);

        // Change password
        await user.updatePassword(_newPasswordController.text);

        if (!mounted) {
          return; // Check if widget is still mounted before using context
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password successfully changed')),
        );

        // Navigate to home screen
        if (mounted) {
          Navigator.of(context).pushReplacementNamed('/home');
        }
      } catch (e) {
        if (!mounted) {
          return; // Ensure the widget is mounted before showing the error
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal karena passworld lama anda salah')),
        );
      }
    } else {
      if (!mounted) {
        return; // Check if widget is mounted before showing the error
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
    }
  }

  // Notification switch for prayer time
  Widget _buildNotificationSwitch() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Prayer time notifications',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Switch(
              value: notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
              activeColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

// Logout button
  Widget _buildLogoutButton() {
    return ElevatedButton(
      onPressed: () {
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/'); // Navigate out
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        backgroundColor: const Color.fromARGB(255, 209, 18, 4),
        textStyle: const TextStyle(
          fontSize: 18,
        ),
        foregroundColor: Colors.white, // Set text color to white
      ),
      child: const Text('Log Out'),
    );
  }
}
