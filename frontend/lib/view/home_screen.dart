import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/models/user.dart';
import 'package:event_management_app/view/widgets/event_item.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> events = [
    Event(
      title: 'Họp phụ huynh',
      description: 'Đây là buổi họp phụ huynh hằng năm',
      eventType: 'Annual Meeting',
      location: 'Tôn Đức Thắng University',
      createdBy: User(
        name: 'GVCN',
        email: 'gvcn@tdtu.edu.vn',
        phoneNumber: '0123456789',
        profilePicture: '',
      ),
      from: DateTime(2025, 1, 1, 9),
      to: DateTime(2025, 1, 1, 12),
    ),
    Event(
      title: 'Họp phụ huynh',
      description: 'Đây là buổi họp phụ huynh hằng năm',
      eventType: 'Annual Meeting',
      location: 'Tôn Đức Thắng University',
      createdBy: User(
        name: 'GVCN',
        email: 'gvcn@tdtu.edu.vn',
        phoneNumber: '0123456789',
        profilePicture: '',
      ),
      from: DateTime(2025, 1, 1, 9),
      to: DateTime(2025, 1, 1, 12),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              child: Text('Welcome user'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (events.isNotEmpty)
              for (Event event in events) EventItem(event: event)
            else
              Container(
                alignment: Alignment.center,
                height: 500,
                child: Text('The list is empty'),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-new-event');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
