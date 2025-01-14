import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/main.dart';
import 'package:flutter/material.dart';

class ThemeController with ChangeNotifier {
  ThemeMode currentTheme = ThemeMode.light;

  ThemeController() {
    String? savedTheme = preferences.getString('THEME');
    if (savedTheme == 'light') {
      currentTheme = ThemeMode.light;
    }
    if (savedTheme == 'dark') {
      currentTheme = ThemeMode.dark;
    }
    notifyListeners();
  }

  void toggleTheme() {
    if (currentTheme == ThemeMode.dark) {
      currentTheme = ThemeMode.light;
      preferences.setString('THEME', 'light');
    } else {
      currentTheme = ThemeMode.dark;
      preferences.setString('THEME', 'dark');
    }
    notifyListeners();
  }

  void setLocale({
    required BuildContext context,
    Locale locale = const Locale('en', 'US'),
  }) {
    context.setLocale(locale);
  }
}
