// ignore_for_file: deprecated_member_use

import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/speaker_controller.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditSpeakerScreen extends StatefulWidget {
  final Speaker speaker;
  const EditSpeakerScreen({Key? key, required this.speaker}) : super(key: key);

  @override
  State<EditSpeakerScreen> createState() => _EditSpeakerScreenState();
}

class _EditSpeakerScreenState extends State<EditSpeakerScreen> {
  final eventFormKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    setState(() {
      nameController.text = widget.speaker.name;
      bioController.text = widget.speaker.bio;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SpeakerController>(
      builder: (context, speakerController, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit speaker'),
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
                        controller: nameController,
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
                        controller: bioController,
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
                            speakerController
                                .editSpeaker(
                              Speaker(
                                id: widget.speaker.id,
                                name: nameController.text,
                                bio: bioController.text,
                                profilePicture: widget.speaker.profilePicture,
                              ),
                            )
                                .then((success) {
                              if (success) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text("Edit speaker success"),
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
