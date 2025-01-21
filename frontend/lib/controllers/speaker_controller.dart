import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:flutter/material.dart';

class SpeakerController with ChangeNotifier {
  List<Speaker> speakers = [];
  bool loading = false;

  // Lấy list events từ API
  Future<void> getSpeakerList() async {
    try {
      loading = true;
      notifyListeners();
      speakers = await API().getSpeakers();
      notifyListeners();
      loading = false;
      notifyListeners();
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
    }
  }
}
