import 'package:event_management_app/api.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/models/ticket.dart';
import 'package:flutter/material.dart';

class EventController with ChangeNotifier {
  List<Event> events = [];
  List<Ticket> myTickets = [];
  bool loading = false;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventCategoryController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  DateTime eventDate = DateTime.now();

  // Update date của event
  void updateEventDate(DateTime dateTime) {
    eventDate = dateTime;
    notifyListeners();
  }

  void createEvent() {
    // Thêm event mới vào list
    events.add(Event(
      title: eventNameController.text,
      description: eventDescriptionController.text,
      category: eventCategoryController.text,
      location: eventLocationController.text,
      date: eventDate,
    ));
    // Clear hết cái ô nhập sau khi submit
    resetEvent();
    notifyListeners();
  }

  // Clear hết input
  void resetEvent() {
    eventDate = DateTime.now();
    eventNameController.clear();
    eventDescriptionController.clear();
    eventCategoryController.clear();
    eventLocationController.clear();
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
  Future<Event?> getDetailEvent(int id) async {
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
