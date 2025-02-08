import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/controllers/home_controller.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EventController>(context, listen: false).getEventList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventController, HomeController>(
      builder: (context, eventController, homeController, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('home_screen.all_events'.tr()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (eventController.loading)
                    const CircularProgressIndicator()
                  else if (eventController.events.isNotEmpty)
                    for (Event event in eventController.events)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: EventItem(
                          event: event,
                          width: MediaQuery.of(context).size.width,
                          canEdit: homeController.currentUser?.role ==
                                  'admin' ||
                              homeController.currentUser?.role == 'organizer',
                        ),
                      )
                  else
                    Container(
                      alignment: Alignment.center,
                      height: 500,
                      child: Text('home_screen.list_empty'.tr()),
                    )
                ],
              ),
            ),
          ),
          floatingActionButton: (homeController.currentUser?.role == 'admin' ||
                  homeController.currentUser?.role == 'organizer')
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-new-event');
                  },
                  child: const Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
