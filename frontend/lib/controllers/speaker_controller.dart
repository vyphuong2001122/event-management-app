import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:flutter/material.dart';

class SpeakerController with ChangeNotifier {
  List<Speaker> speakers = [];
  bool loading = false;

  TextEditingController speakerNameController = TextEditingController();
  TextEditingController speakerBioController = TextEditingController();

  // Lấy list speakers từ API
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

  Future<bool> createSpeaker() async {
    try {
      loading = true;
      notifyListeners();
      Speaker newSpeaker = Speaker(
        name: speakerNameController.text,
        bio: speakerBioController.text,
        profilePicture: 'image.png',
        id: 0,
      );
      bool success = await API().addNewSpeaker(newSpeaker);
      if (success) {
        // Thêm speaker mới vào list
        speakers.add(newSpeaker);
        // Clear hết cái ô nhập sau khi submit
        resetSpeakerInput();
        loading = false;
        notifyListeners();
      }
      return success;
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> editSpeaker(Speaker speaker) async {
    try {
      loading = true;
      notifyListeners();
      bool success = await API().updateSpeaker(speaker);
      if (success) {
        getSpeakerList();
      }
      return success;
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
      return false;
    }
  }

  // Clear hết input
  void resetSpeakerInput() {
    speakerNameController.clear();
    speakerBioController.clear();
    notifyListeners();
  }
}
