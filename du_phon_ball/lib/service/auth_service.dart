import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import '../models/user.dart';
import '../screens/login_screen.dart';

class AuthService {
  final PocketBase pb = PocketBase('http://127.0.0.1:8090');

  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return regex.hasMatch(email);
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    bool isAdmin = false,
  }) async {
    if (!isValidEmail(email)) {
      throw Exception('Invalid email format');
    }

    try {
      await pb.collection('users').create(body: {
        'username': username,
        'email': email,
        'password': password,
        'passwordConfirm': password,
        'is_admin': isAdmin,
      });
    } catch (error) {
      throw Exception('Registration failed: $error');
    }
  }

  Future<void> loginUser(String email, String password, BuildContext context) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Email and Password cannot be empty.');
    }

    try {
      final userData = await pb.collection('users').authWithPassword(email, password);

      // Debugging: Print the user data
      print('User Data: ${userData.toJson()}');

      User user = User.fromJson(userData.toJson());

      // Debugging: Check if the user is an admin
      print('User: ${user.email}, Is Admin: ${user.isAdmin}');

      if (user.isAdmin) {
        Navigator.pushReplacementNamed(context, '/admin_dashboard');
      } else {
        Navigator.pushReplacementNamed(context, '/guest_dashboard');
      }
    } catch (error) {
      throw Exception('Login failed: $error');
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    try {
      pb.authStore.clear();
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
    } catch (error) {
      throw Exception('Logout failed: $error');
    }
  }
}