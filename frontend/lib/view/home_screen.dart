import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/controllers/home_controller.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/controllers/theme_controller.dart';
import 'package:event_management_app/models/ticket.dart';
import 'package:event_management_app/models/user.dart';
import 'package:event_management_app/view/widgets/home_menu_widget.dart';
import 'package:event_management_app/view/widgets/section_widget.dart';
import 'package:event_management_app/view/widgets/ticket_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<HomeController>(context, listen: false)
          .getUserProfile()
          .then((success) {
        if (!success && mounted) {
          Provider.of<LoginController>(context, listen: false).logout(context);
        }
      });
      Provider.of<EventController>(context, listen: false).getMyTicketList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/home_background.png'),
            ),
          ),
          Consumer3<ThemeController, HomeController, EventController>(
            builder:
                (context, themeController, homeController, eventController, _) {
              User? user = homeController.currentUser;
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
                          IconButton(
                            icon: const Icon(Icons.qr_code_scanner),
                            onPressed: () {
                              Navigator.pushNamed(context, '/scan-qr');
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'home_screen.welcome_back'.tr(),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            if (user != null)
                              TextSpan(
                                text: user.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      if (eventController.myTickets.isNotEmpty)
                        SectionWidget(
                          title: 'home_screen.your_events'.tr(),
                          content: SizedBox(
                            height: 240,
                            width: double.infinity,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 8),
                              children: [
                                for (Ticket ticket in eventController.myTickets)
                                  TicketItem(
                                    ticket: ticket,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                      SectionWidget(
                        title: 'home_screen.functions'.tr(),
                        content: Wrap(
                          children: [
                            HomeMenuWidget(
                              icon: 'assets/images/icon_calendar.png',
                              title: 'home_screen.all_events'.tr(),
                              onTap: () {
                                Navigator.pushNamed(context, '/event-list');
                              },
                            ),
                            if (user?.role == 'admin')
                              HomeMenuWidget(
                                icon: 'assets/images/icon_profile.png',
                                title: 'home_screen.users'.tr(),
                                onTap: () {
                                  Navigator.pushNamed(context, '/user-list');
                                },
                              ),
                            HomeMenuWidget(
                              icon: 'assets/images/icon_microphone.png',
                              title: 'home_screen.speakers'.tr(),
                            ),
                            HomeMenuWidget(
                                icon: 'assets/images/icon_settings.png',
                                title: 'home_screen.settings'.tr(),
                                onTap: () {
                                  Navigator.pushNamed(context, '/settings');
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
