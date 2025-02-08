import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:event_management_app/models/ticket.dart';
import 'package:flutter/material.dart';

class EventController with ChangeNotifier {
  List<Event> events = [];
  List<Ticket> myTickets = [];
  bool loading = false;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventCategoryController = TextEditingController(
    text: 'Workshop',
  );
  TextEditingController eventLocationController = TextEditingController();
  DateTime eventDate = DateTime.now();
  List<Speaker> speakers = [];

  // Update date của event
  void updateEventDate(DateTime dateTime) {
    eventDate = dateTime;
    notifyListeners();
  }

  Future<bool> createEvent() async {
    try {
      loading = true;
      notifyListeners();
      Event newEvent = Event(
        title: eventNameController.text,
        description: eventDescriptionController.text,
        category: eventCategoryController.text,
        location: eventLocationController.text,
        date: eventDate,
        speakers: speakers,
      );
      bool success = await API().addNewEvent(newEvent);
      if (success) {
        // Thêm event mới vào list
        events.add(newEvent);
        // Clear hết cái ô nhập sau khi submit
        resetEvent();
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

  void selectSpeaker(Speaker speaker) {
    if (!speakers.contains(speaker)) {
      speakers.add(speaker);
    }
    notifyListeners();
  }

  void deselectSpeaker(Speaker speaker) {
    if (speakers.contains(speaker)) {
      speakers.remove(speaker);
    }
    notifyListeners();
  }

  // Clear hết input
  void resetEvent() {
    eventDate = DateTime.now();
    eventNameController.clear();
    eventDescriptionController.clear();
    eventCategoryController.clear();
    eventLocationController.clear();
    speakers.clear();
    notifyListeners();
  }

  // Lấy list events từ API
  Future<void> getEventList() async {
    try {
      loading = true;
      notifyListeners();
      events = await API().getEventList();
      notifyListeners();
      loading = false;
      notifyListeners();
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
    }
  }

  // Lấy list events từ API
  Future<void> getMyTicketList() async {
    try {
      loading = true;
      notifyListeners();
      myTickets = await API().getMyTicketList();
      notifyListeners();
      loading = false;
      notifyListeners();
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
    }
  }

  // Lấy 1 event chi tiết từ API
  Future<Event?> getDetailEvent(String id) async {
    try {
      loading = true;
      notifyListeners();
      Event? event = await API().getEventDetail(id);
      loading = false;
      notifyListeners();
      return event;
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
      return null;
    }
  }

  // Đăng ký tham gia 1 event
  Future<String?> registerForEvent(int id) async {
    try {
      loading = true;
      notifyListeners();
      String? qrKey = await API().registerForEvent(id);
      await getMyTicketList();
      loading = false;
      notifyListeners();
      return qrKey;
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
      return null;
    }
  }

  // Organizer quét mã QR
  Future<bool> validateAttendance(String qr) async {
    try {
      loading = true;
      notifyListeners();
      bool success = await API().validateAttendance(qr);
      await getMyTicketList();
      loading = false;
      notifyListeners();
      return success;
    } catch (e, st) {
      print('$e $st');
      loading = false;
      notifyListeners();
      return false;
    }
  }
}
