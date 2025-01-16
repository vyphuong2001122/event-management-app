import 'package:event_management_app/models/event.dart';

class Ticket {
  final Event event;
  final int eventId;
  final bool hasAttended;
  final String qrKey;

  Ticket({
    required this.event,
    required this.eventId,
    required this.qrKey,
    this.hasAttended = false,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      event: Event.fromJson(json['Event']),
      eventId: json['eventId'],
      qrKey: json['qrKey'],
      hasAttended: json['attended'] == true,
    );
  }
}
