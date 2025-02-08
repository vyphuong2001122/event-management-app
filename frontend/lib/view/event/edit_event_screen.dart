// ignore_for_file: deprecated_member_use

import 'package:dropdown_search/dropdown_search.dart';
import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/controllers/speaker_controller.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EditEventScreen extends StatefulWidget {
  final Event event;
  const EditEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final eventFormKey = GlobalKey<FormState>();
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventLocationController = TextEditingController();
  TextEditingController eventCategoryController = TextEditingController();
  DateTime eventDateTime = DateTime.now();
  List<Speaker> eventSpeakers = [];

  @override
  void initState() {
    setState(() {
      eventNameController.text = widget.event.title;
      eventDescriptionController.text = widget.event.description;
      eventLocationController.text = widget.event.location;
      eventCategoryController.text = widget.event.category;
      eventDateTime = widget.event.date;
      eventSpeakers = widget.event.speakers;
    });
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<SpeakerController>(context, listen: false).getSpeakerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EventController, SpeakerController>(
      builder: (context, eventController, speakerController, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit event "${widget.event.title}"'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: eventFormKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event name',
                        ),
                        controller: eventNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event description',
                        ),
                        controller: eventDescriptionController,
                        keyboardType: TextInputType.text,
                        maxLines: 4,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          DateFormat('dd/MM/yyyy').format(eventDateTime),
                        ),
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: eventDateTime,
                          firstDate: eventDateTime.isBefore(DateTime.now())
                              ? eventDateTime
                              : DateTime.now(),
                          lastDate: DateTime(2050),
                        ).then((value) {
                          setState(() {
                            if (value != null) {
                              eventDateTime = value;
                            }
                          });
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownSearch<String>(
                        decoratorProps: DropDownDecoratorProps(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          if (value != null) {
                            eventCategoryController.text = value;
                          }
                        },
                        items: (f, cs) => [
                          'Workshop',
                          'Seminar',
                          'Conference',
                          'Competition',
                        ],
                        selectedItem: eventCategoryController.text,
                        popupProps: PopupProps.menu(
                          fit: FlexFit.loose,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event location',
                        ),
                        controller: eventLocationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Speakers',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    for (Speaker speaker in speakerController.speakers)
                      CheckboxListTile(
                        secondary: CircleAvatar(
                          foregroundImage: AssetImage(
                            'assets/images/avatar_illustration.jpg',
                          ),
                        ),
                        value: eventSpeakers.contains(speaker),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              if (!eventSpeakers.contains(speaker)) {
                                eventSpeakers.add(speaker);
                              }
                            }
                            if (value == false) {
                              if (eventSpeakers.contains(speaker)) {
                                eventSpeakers.remove(speaker);
                              }
                            }
                          });
                        },
                        title: Text(speaker.name),
                      ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          bool valid = eventFormKey.currentState!.validate();
                          if (valid) {
                            eventController
                                .updateEvent(Event(
                              id: widget.event.id,
                              title: eventNameController.text,
                              description: eventDescriptionController.text,
                              location: eventLocationController.text,
                              category: eventCategoryController.text,
                              date: eventDateTime,
                              speakers: eventSpeakers,
                            ))
                                .then((success) {
                              if (success) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Add event success"),
                                ));
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        minWidth: 250,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        textColor: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        color: primaryColor,
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
