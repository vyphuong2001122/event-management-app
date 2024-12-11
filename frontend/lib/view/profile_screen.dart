import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
                Text('Name: ', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 20),
                Text('Nguyen Le Phuong Vy'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Address: ',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 20),
                Text('Tran Xuan Soan, Tan Hung, Quan 7'),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Phone Number: ',
                    style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 20),
                Text('01234567890'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
