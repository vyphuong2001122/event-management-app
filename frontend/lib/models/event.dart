class Event {
  final int? id;
  final String title;
  final String description;
  final String location;
  final String category;
  final DateTime date;

  Event({
    this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.date,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['name'],
      description: json['description'],
      location: json['location'],
      category: json['category'] ?? '',
      date: DateTime.tryParse(json['date'] ?? '') ?? DateTime.now(),
    );
  }
}
