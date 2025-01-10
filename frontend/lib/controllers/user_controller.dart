import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/user.dart';
import 'package:flutter/material.dart';

class UserController with ChangeNotifier {
  List<User> users = [];
  bool loading = false;

  Future<void> getUserList() async {
    try {
      loading = true;
      notifyListeners();
      users = await API().getUserList();
      notifyListeners();
      loading = false;
      notifyListeners();
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
    }
  }

  void updateUserRole(int userId, String role) {
    User? findUser = users.where((e) => e.id == userId).firstOrNull;
    if (findUser != null) {
      findUser.role = role;
    }
    notifyListeners();
  }
}
