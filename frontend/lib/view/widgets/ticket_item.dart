import 'package:event_management_app/colors.dart';
import 'package:event_management_app/models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TicketItem extends StatefulWidget {
  final Ticket ticket;
  final double width;
  const TicketItem({super.key, required this.ticket, this.width = 300});

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/event-detail', arguments: {
          'id': widget.ticket.eventId,
          'qr': widget.ticket.qrKey,
        });
      },
      child: Container(
        width: widget.width,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
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
              width: widget.width,
              height: 96,
              child: Image.asset(
                'assets/images/event_illustration.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            ListTile(
              title: Text(
                widget.ticket.event.title,
                maxLines: 1,
              ),
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Theme.of(context).colorScheme.onBackground,
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.ticket.event.description,
                      style: const TextStyle(color: Colors.grey),
                      maxLines: 1,
                    ),
                    if (widget.ticket.event.location.isNotEmpty)
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
                              widget.ticket.event.location,
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
                            DateFormat('dd/MM/yyyy - HH:mm')
                                .format(widget.ticket.event.date),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                    if (widget.ticket.hasAttended)
                      const Chip(
                        label: Text(
                          'Used',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                        side: BorderSide.none,
                      ),
                  ],
                ),
              ),
              tileColor: Theme.of(context).colorScheme.surface,
            ),
          ],
        ),
      ),
    );
  }
}
