import 'package:event_management_app/colors.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text('Name: ',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                SizedBox(width: 20),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter your name',
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Name required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Text('Address: ',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                SizedBox(width: 20),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter your address',
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Address required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                    child: Text('Phone Number: ',
                        style: TextStyle(fontWeight: FontWeight.w600))),
                SizedBox(width: 20),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        hintText: 'Enter your phone number',
                      ),
                      controller: nameController,
                      keyboardType: TextInputType.phone,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Phone number required';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                minWidth: 250,
                height: 50,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textColor: Colors.white,
                color: primaryColor,
                child: Text(
                  'SAVE',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
