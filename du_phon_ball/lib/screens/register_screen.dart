import 'package:flutter/material.dart';
import '../service/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isAdmin = false;
  String? errorMessage; // For displaying errors

  void register() async {
    if (_usernameController.text.isEmpty || _emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        errorMessage = 'All fields are required!';
      });
      return;
    }
    
    try {
      await AuthService().registerUser(
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        isAdmin: isAdmin,
      );
      Navigator.pushReplacementNamed(context, '/login');
    } catch (error) {
      setState(() {
        errorMessage = 'Registration failed: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null) ...[
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
              SizedBox(height: 10),
            ],
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            Row(
              children: [
                Checkbox(
                  value: isAdmin,
                  onChanged: (value) {
                    setState(() {
                      isAdmin = value!;
                    });
                  },
                ),
                Text('Register as Admin'),
              ],
            ),
            ElevatedButton(
              onPressed: register,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
