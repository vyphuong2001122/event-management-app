import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/controllers/home_controller.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/controllers/profile_controller.dart';
import 'package:event_management_app/controllers/register_controller.dart';
import 'package:event_management_app/controllers/speaker_controller.dart';
import 'package:event_management_app/controllers/theme_controller.dart';
import 'package:event_management_app/controllers/user_controller.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:event_management_app/view/event/add_new_event_screen.dart';
import 'package:event_management_app/view/event/event_detail_screen.dart';
import 'package:event_management_app/view/event/event_list_screen.dart';
import 'package:event_management_app/view/event/scan_qr_screen.dart';
import 'package:event_management_app/view/home_screen.dart';
import 'package:event_management_app/view/login/login_screen.dart';
import 'package:event_management_app/view/login/register_screen.dart';
import 'package:event_management_app/view/profile/edit_profile_screen.dart';
import 'package:event_management_app/view/profile/profile_screen.dart';
import 'package:event_management_app/view/settings_screen.dart';
import 'package:event_management_app/view/speaker/add_new_speaker_screen.dart';
import 'package:event_management_app/view/speaker/edit_speaker_screen.dart';
import 'package:event_management_app/view/speaker/speaker_list_screen.dart';
import 'package:event_management_app/view/user/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences preferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();
  preferences = await SharedPreferences.getInstance();
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EventController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => RegisterController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ProfileController()),
        ChangeNotifierProvider(create: (_) => SpeakerController()),
      ],
      child: EasyLocalization(
          supportedLocales: const [
            Locale('en', 'US'),
            Locale('vi', 'VN'),
          ],
          path: 'translations',
          fallbackLocale: const Locale('en', 'US'),
          child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeController, _) {
        return MaterialApp(
          title: 'Event Management Application',
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            fontFamily: 'Poppins',
            appBarTheme: const AppBarTheme(
              color: backgroundColor,
            ),
            colorScheme: const ColorScheme.light(
              background: backgroundColor,
              primary: primaryColor,
              secondary: secondaryColor,
            ),
            useMaterial3: true,
          ),
          themeMode: themeController.currentTheme,
          darkTheme: ThemeData(
            scaffoldBackgroundColor: backgroundColorDark,
            fontFamily: 'Poppins',
            appBarTheme: const AppBarTheme(
              color: backgroundColorDark,
            ),
            colorScheme: const ColorScheme.dark(
              background: backgroundColorDark,
              primary: primaryColor,
              secondary: secondaryColor,
            ),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: '/login',
          onGenerateInitialRoutes: (route) {
            return [MaterialPageRoute(builder: (_) => const LoginScreen())];
          },
          routes: {
            '/login': (context) => const LoginScreen(),
            '/': (context) => const HomeScreen(),
            '/add-new-event': (context) => const AddNewEventScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/edit-profile': (context) => const EditProfileScreen(),
            '/register': (context) => const RegisterScreen(),
            '/scan-qr': (context) => const ScanQrScreen(),
            '/event-list': (context) => const EventListScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/user-list': (context) => const UserListScreen(),
            '/speaker-list': (context) => const SpeakerListScreen(),
            '/add-new-speaker': (context) => const AddNewSpeakerScreen(),
          },
          onGenerateRoute: (settings) {
            final uri = Uri.parse(settings.name!);

            // Handle dynamic route: "/event-detail/:id"
            if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'event-detail') {
              final eventId = uri.pathSegments[1]; // Extract event ID
              final eventQr = settings.arguments as String?; // Extract event QR
              return MaterialPageRoute(
                builder: (context) =>
                    EventDetailScreen(id: eventId, qr: eventQr),
              );
            }

            // Handle dynamic route: "/speakers/:id/edit"
            if (uri.pathSegments.length == 3 &&
                uri.pathSegments.first == 'speakers' &&
                uri.pathSegments.last == 'edit') {
              final speaker =
                  settings.arguments as Speaker; // Extract the object

              return MaterialPageRoute(
                builder: (context) => EditSpeakerScreen(speaker: speaker),
              );
            }

            // Return null to indicate an unknown route
            return null;
          },
        );
      },
    );
  }
}
