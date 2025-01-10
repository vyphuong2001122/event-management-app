import 'package:event_management_app/api.dart';
import 'package:event_management_app/main.dart';
import 'package:flutter/material.dart';

class LoginController with ChangeNotifier {
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showPassword = false;
  bool loading = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void login(BuildContext context) async {
    // Thành công
    loading = true;
    notifyListeners();
    if (loginFormKey.currentState!.validate()) {
      // Gọi API để login
      bool success =
          await API().login(emailController.text, passwordController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Login success"),
        ));
        Navigator.pushReplacementNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Wrong email or password"),
        ));
      }
    }
    loading = false;
    notifyListeners();
  }

  void logout(BuildContext context) {
    preferences.clear();
  }
}
