import 'package:event_management_app/models/speaker.dart';

class Event {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String category;
  final DateTime date;
  final List<Speaker> speakers;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.date,
    this.speakers = const [],
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    List<Speaker> speakers = [];
    if (json['Speakers'] != null) {
      for (Map<String, dynamic> speaker in json['Speakers']) {
        speakers.add(Speaker.fromJson(speaker));
      }
    }
    return Event(
      id: json['id'],
      title: json['name'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
      speakers: speakers,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': title,
      'description': description,
      'location': location,
      'category': category,
      'date': date.toIso8601String(),
      'speakers': speakers.map((e) => e.id).toList(),
    };
  }
}
