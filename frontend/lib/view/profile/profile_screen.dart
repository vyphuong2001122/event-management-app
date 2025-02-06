import 'package:easy_localization/easy_localization.dart';
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
        height: 60,
        margin: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            Provider.of<LoginController>(context, listen: false)
                .logout(context);
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Material(
            elevation: 5.0,
            shadowColor: Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'settings_screen.logout'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
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
