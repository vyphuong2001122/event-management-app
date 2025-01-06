import 'package:event_management_app/controllers/theme_controller.dart';
import 'package:event_management_app/models/event.dart';
import 'package:event_management_app/view/widgets/event_item.dart';
import 'package:event_management_app/view/widgets/home_menu_widget.dart';
import 'package:event_management_app/view/widgets/section_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Event> events = [
    Event(
      title: 'YEAR END PARTY',
      description: 'This is a YEP event',
      date: DateTime.now(),
      category: 'Party',
      location: 'Main Hall',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<ThemeController>(builder: (context, themeController, _) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: themeController.currentTheme == ThemeMode.dark
                              ? const Icon(Icons.dark_mode)
                              : const Icon(Icons.light_mode),
                          onPressed: () {
                            themeController.toggleTheme();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.qr_code_scanner),
                          onPressed: () {
                            Navigator.pushNamed(context, '/scan-qr');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Welcome back, ',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextSpan(
                        text: 'Phuong Vy',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                SectionWidget(
                  title: 'Your events',
                  content: SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      children: [
                        for (Event event in events)
                          EventItem(
                            event: event,
                          ),
                      ],
                    ),
                  ),
                ),
                SectionWidget(
                  title: 'Hot events',
                  content: SizedBox(
                    height: 240,
                    width: double.infinity,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      children: [
                        for (Event event in events)
                          EventItem(
                            event: event,
                          ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const SectionWidget(
                  title: 'Menus',
                  content: Wrap(
                    children: [
                      HomeMenuWidget(
                        icon: 'assets/images/icon_calendar.png',
                        title: 'All events',
                      ),
                      HomeMenuWidget(
                        icon: 'assets/images/icon_profile.png',
                        title: 'Users',
                      ),
                      HomeMenuWidget(
                        icon: 'assets/images/icon_microphone.png',
                        title: 'Speakers',
                      ),
                      HomeMenuWidget(
                        icon: 'assets/images/icon_settings.png',
                        title: 'Settings',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-new-event');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
