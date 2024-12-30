import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLightest,
      body: Consumer<LoginController>(builder: (context, controller, child) {
        return Form(
          key: controller.loginFormKey,
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
                    controller: controller.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email required';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Email is not valid';
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
                            controller.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: primaryColor,
                            size: 18,
                          ),
                          onTap: () {
                            controller.toggleShowPassword();
                          },
                        )),
                    controller: controller.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: !controller.showPassword,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      if (value.length < 6) {
                        return 'Password is not strong enough';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: controller.loading
                        ? null
                        : () {
                            controller.login(context);
                          },
                    height: 50,
                    disabledColor: primaryColorLight,
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
        );
      }),
    );
  }
}
