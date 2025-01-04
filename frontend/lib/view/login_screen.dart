import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String? token = preferences.getString('TOKEN');
      // Nếu đã có token, tức là đã login
      // Vào thẳng trang home
      if ((token ?? '').isNotEmpty) {
        Navigator.pushReplacementNamed(context, '/');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorLightest,
      body: Consumer<LoginController>(builder: (context, controller, child) {
        return Form(
          key: controller.loginFormKey,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(80),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 8,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Image.asset('assets/images/logo_white.png'),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.asset('assets/images/login_background.png'),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border:
                                OutlineInputBorder(borderSide: BorderSide.none),
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
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Enter your password',
                              prefixIcon:
                                  const Icon(Icons.key, color: primaryColor),
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
                      const SizedBox(height: 20),
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
                            borderRadius: BorderRadius.circular(20),
                          ),
                          textColor: Colors.white,
                          color: primaryColor,
                          child: controller.loading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  'LOGIN',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        child: const Text(
                          'Don\'t have an account? Sign up for one',
                          style: TextStyle(color: primaryColor),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
