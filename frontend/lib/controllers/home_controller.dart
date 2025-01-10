import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/user.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {
  User? currentUser;

  Future<bool> getUserProfile() async {
    try {
      User? user = await API().getUserProfile();
      if (user != null) {
        currentUser = user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
