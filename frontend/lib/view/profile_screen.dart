import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/home_controller.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MaterialButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile');
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: MaterialButton(
          onPressed: () {
            Provider.of<LoginController>(context, listen: false)
                .logout(context);
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/login');
          },
          height: 50,
          disabledColor: primaryColorLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textColor: Colors.white,
          color: primaryColor,
          child: const Text(
            'LOGOUT',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
      body: Consumer<HomeController>(builder: (context, homeController, _) {
        User? user = homeController.currentUser;
        if (user == null) {
          return Container();
        }
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 60,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Name: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 20),
                  Text(user.name),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Email: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(width: 20),
                  Text(user.email),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
