import 'package:event_management_app/api.dart';
import 'package:flutter/material.dart';

class ProfileController with ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  bool loading = false;

  Future<bool> saveProfile() {
    loading = true;
    notifyListeners();
    return API()
        .updateUserProfile(
      name: nameController.text,
    )
        .then((success) {
      loading = false;
      notifyListeners();
      return success;
    }).onError((error, stackTrace) {
      loading = false;
      notifyListeners();
      return false;
    });
  }
}
