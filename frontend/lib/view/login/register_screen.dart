import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up for an account'),
      ),
      body: Consumer<RegisterController>(
          builder: (context, registerController, _) {
        return Form(
          key: registerController.registerFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset('assets/images/register_background.jpg'),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Enter your email',
                    ),
                    controller: registerController.emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Enter your password',
                    ),
                    controller: registerController.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Enter your password again',
                    ),
                    controller: registerController.passwordConfirmController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password required';
                      }
                      if (value != registerController.passwordController.text) {
                        return 'The password you re-entered was not matched';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      hintText: 'Enter your name',
                    ),
                    controller: registerController.nameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () {
                      bool validate = registerController
                          .registerFormKey.currentState!
                          .validate();
                      if (validate) {
                        registerController.register(context);
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minWidth: 250,
                    height: 50,
                    textColor: Colors.white,
                    color: primaryColor,
                    child: registerController.loading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'REGISTER',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      }),
    );
  }
}
