import 'package:event_management_app/models/event.dart';
import 'package:flutter/material.dart';

class EventController with ChangeNotifier {
  List<Event> events = [];

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
    print('Event name: ${eventNameController.text}');
    print('Event description: ${eventDescriptionController.text}');
    print('Event date: $eventDate');
    print('Event category: ${eventCategoryController.text}');

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
  }
}
