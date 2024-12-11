import 'package:event_management_app/colors.dart';
import 'package:event_management_app/view/add_new_event_screen.dart';
import 'package:event_management_app/view/home_screen.dart';
import 'package:event_management_app/view/login_screen.dart';
import 'package:event_management_app/view/profile_screen.dart';
import 'package:event_management_app/view/register_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Management Application',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: backgroundColor,
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) => const HomeScreen(),
        '/add-new-event': (context) => const AddNewEventScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}
