// ignore_for_file: deprecated_member_use

import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/speaker_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddNewSpeakerScreen extends StatefulWidget {
  const AddNewSpeakerScreen({Key? key}) : super(key: key);

  @override
  State<AddNewSpeakerScreen> createState() => _AddNewSpeakerScreenState();
}

class _AddNewSpeakerScreenState extends State<AddNewSpeakerScreen> {
  final eventFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeakerController>(
      builder: (context, speakerController, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Add new speaker'),
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
                          hintText: 'Enter speaker name',
                        ),
                        controller: speakerController.speakerNameController,
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
                          hintText: 'Enter speaker bio',
                        ),
                        controller: speakerController.speakerBioController,
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
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        onPressed: () {
                          bool valid = eventFormKey.currentState!.validate();
                          if (valid) {
                            speakerController.createSpeaker().then((success) {
                              if (success) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Add speaker success"),
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
                          'ADD',
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
