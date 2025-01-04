import 'package:event_management_app/colors.dart';
import 'package:event_management_app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventItem extends StatefulWidget {
  final Event event;
  const EventItem({super.key, required this.event});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        children: [
          SizedBox(
            width: 300,
            height: 96,
            child: Image.asset(
              'assets/images/event_illustration.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          ListTile(
            title: Text(
              widget.event.title,
              maxLines: 1,
            ),
            titleTextStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.description,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          widget.event.location,
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.timer,
                        color: primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(widget.event.date),
                          maxLines: 1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            tileColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
