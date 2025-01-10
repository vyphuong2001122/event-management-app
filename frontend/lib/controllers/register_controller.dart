import 'package:event_management_app/api.dart';
import 'package:event_management_app/main.dart';
import 'package:flutter/material.dart';

class RegisterController with ChangeNotifier {
  final registerFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  bool showPassword = false;
  bool loading = false;

  void toggleShowPassword() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void register(BuildContext context) async {
    // Thành công
    loading = true;
    notifyListeners();
    if (registerFormKey.currentState!.validate()) {
      // Gọi API để register
      bool success = await API().register(
          emailController.text, passwordController.text, nameController.text);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Register success"),
        ));
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacementNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Register failed. Please try again."),
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
