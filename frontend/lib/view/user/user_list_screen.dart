import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/user_controller.dart';
import 'package:event_management_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserController>(context, listen: false).getUserList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: Consumer<UserController>(
        builder: (context, userController, _) {
          List<User> users = userController.users;
          return SingleChildScrollView(
            child: Column(
              children: [
                for (User user in users)
                  ListTile(
                    title: Text(user.name),
                    leading: const CircleAvatar(),
                    subtitle: Text(user.email),
                    trailing: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Center(
                                child: Text('Update role'),
                              ),
                              alignment: Alignment.center,
                              titlePadding: const EdgeInsets.all(20),
                              contentPadding: const EdgeInsets.all(20),
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Role',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: DropdownButton<String>(
                                        items: const [
                                          DropdownMenuItem<String>(
                                            value: 'attendee',
                                            child: Text('attendee'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'admin',
                                            child: Text('admin'),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'organizer',
                                            child: Text('organizer'),
                                          ),
                                        ],
                                        value: user.role,
                                        onChanged: (value) {
                                          if (value != null) {
                                            userController.updateUserRole(
                                              user.id,
                                              value,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    height: 50,
                                    disabledColor: primaryColorLight,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    textColor: Colors.white,
                                    color: primaryColor,
                                    child: userController.loading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(),
                                          )
                                        : const Text(
                                            'SAVE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
