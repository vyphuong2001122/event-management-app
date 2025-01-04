import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/view/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatefulWidget {
  const EventListScreen({super.key});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<EventController>(builder: (context, controller, child) {
        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (controller.events.isNotEmpty)
                for (Event event in controller.events) EventItem(event: event)
              else
                Container(
                  alignment: Alignment.center,
                  height: 500,
                  child: const Text('The list is empty'),
                )
            ],
          ),
        );
      }),
    );
  }
}
