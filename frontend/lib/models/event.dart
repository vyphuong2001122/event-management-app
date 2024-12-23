import 'package:event_management_app/models/user.dart';

class Event {
  final String title;
  final String description;
  final String location;
  final String category;
  final User? createdBy;
  final DateTime date;

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    this.createdBy,
    required this.date,
  });
}
