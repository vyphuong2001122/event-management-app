import 'package:event_management_app/colors.dart';
import 'package:event_management_app/models/event.dart';
import 'package:flutter/material.dart';

class EventItem extends StatefulWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: ListTile(
        title: Text(widget.event.title),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.event.description,
                style: TextStyle(color: Colors.grey),
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text(widget.event.location),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.timer,
                    color: primaryColor,
                  ),
                  SizedBox(width: 10),
                  Text('${widget.event.from} - ${widget.event.to}'),
                ],
              ),
            ],
          ),
        ),
        tileColor: Colors.white,
      ),
    );
  }
}
