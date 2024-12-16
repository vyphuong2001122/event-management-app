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
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLightest,
      body: Form(
        key: loginFormKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset('assets/logo.png'),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.email, color: primaryColor),
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
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Enter your password',
                      prefixIcon: Icon(Icons.key, color: primaryColor),
                      suffixIcon: InkWell(
                        child: Icon(
                          showPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: primaryColor,
                          size: 18,
                        ),
                        onTap: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      )),
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: showPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password required';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    login();
                  },
                  height: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textColor: Colors.white,
                  color: primaryColor,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                child: Text('Register a new account',
                    style: TextStyle(color: primaryColor)),
                onTap: () {},
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
      Navigator.pushReplacementNamed(context, '/');
    }
  }
}
