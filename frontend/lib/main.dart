import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/controllers/home_controller.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/controllers/profile_controller.dart';
import 'package:event_management_app/controllers/register_controller.dart';
import 'package:event_management_app/controllers/theme_controller.dart';
import 'package:event_management_app/controllers/user_controller.dart';
import 'package:event_management_app/view/add_new_event_screen.dart';
import 'package:event_management_app/view/edit_profile_screen.dart';
import 'package:event_management_app/view/event_detail_screen.dart';
import 'package:event_management_app/view/event_list_screen.dart';
import 'package:event_management_app/view/home_screen.dart';
import 'package:event_management_app/view/login_screen.dart';
import 'package:event_management_app/view/profile_screen.dart';
import 'package:event_management_app/view/register_screen.dart';
import 'package:event_management_app/view/scan_qr_screen.dart';
import 'package:event_management_app/view/settings_screen.dart';
import 'package:event_management_app/view/user_list_screen.dart';
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
            '/event-detail': (context) => const EventDetailScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/user-list': (context) => const UserListScreen(),
          },
        );
      },
    );
  }
}
