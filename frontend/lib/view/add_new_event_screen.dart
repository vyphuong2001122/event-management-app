import 'package:event_management_app/colors.dart';
import 'package:flutter/material.dart';

class AddNewEventScreen extends StatefulWidget {
  const AddNewEventScreen({Key? key}) : super(key: key);

  @override
  State<AddNewEventScreen> createState() => _AddNewEventScreenState();
}

class _AddNewEventScreenState extends State<AddNewEventScreen> {
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new event'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter event name',
                ),
                controller: eventNameController,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter event description',
                ),
                controller: eventDescriptionController,
                keyboardType: TextInputType.text,
                maxLines: 4,
              ),
              SizedBox(height: 10),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 250,
                height: 50,
                textColor: Colors.white,
                color: primaryColor,
                child: Text(
                  'ADD',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
