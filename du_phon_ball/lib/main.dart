import 'package:flutter/material.dart';
import 'screens/guest_dashboard.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DU Phone Ball',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/guest_dashboard': (context) => GuestDashboardScreen(), // For Guest
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(child: Text('Page not found')),
        ),
      ),
    );
  }
}
