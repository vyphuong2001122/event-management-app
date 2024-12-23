import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void login(BuildContext context) {
    // Thành công
    if (loginFormKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Login success"),
      ));
    }
  }
}
