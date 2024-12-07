import 'package:event_management_app/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your email',
                ),
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your password',
                ),
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  login();
                },
                minWidth: 250,
                height: 50,
                textColor: Colors.white,
                color: primaryColor,
                child: Text(
                  'LOGIN',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    // Thành công
    if (loginFormKey.currentState!.validate()) {
      print('Success');
    }
  }
}
