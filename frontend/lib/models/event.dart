import 'package:event_management_app/models/user.dart';

class Event {
  final String title;
  final String description;
  final String location;
  final String eventType;
  final User createdBy;
  final DateTime from;
  final DateTime to;

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.eventType,
    required this.createdBy,
    required this.from,
    required this.to,
  });
}
