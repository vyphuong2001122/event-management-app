import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({Key? key}) : super(key: key);

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  final eventFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<EventController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Add new event'),
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
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event name',
                        ),
                        controller: controller.eventNameController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event description',
                        ),
                        controller: controller.eventDescriptionController,
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
                    SizedBox(height: 10),
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
                        padding: EdgeInsets.all(10),
                        child: Text(controller.eventDate.toString()),
                      ),
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: controller.eventDate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2050),
                        ).then((value) {
                          setState(() {
                            if (value != null) {
                              controller.updateEventDate(value);
                            }
                          });
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event category',
                        ),
                        controller: controller.eventCategoryController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          hintText: 'Enter event location',
                        ),
                        controller: controller.eventLocationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          bool valid = eventFormKey.currentState!.validate();
                          if (valid) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Add event success"),
                            ));
                            controller.createEvent();
                            Navigator.pop(context);
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
                          'ADD',
                          style: TextStyle(fontWeight: FontWeight.w600),
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
