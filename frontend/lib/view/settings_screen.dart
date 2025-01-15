import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/controllers/login_controller.dart';
import 'package:event_management_app/controllers/theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_screen.settings'.tr()),
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            Provider.of<LoginController>(context, listen: false)
                .logout(context);
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Material(
            elevation: 5.0,
            shadowColor: Theme.of(context).colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                'settings_screen.logout'.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/images/settings_background.png'),
            ),
          ),
          Consumer<ThemeController>(builder: (context, themeController, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Material(
                      elevation: 5.0,
                      shadowColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text('settings_screen.dark_mode'.tr()),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        leading: themeController.currentTheme == ThemeMode.dark
                            ? const Icon(Icons.dark_mode)
                            : const Icon(Icons.light_mode),
                        trailing: CupertinoSwitch(
                          value: themeController.currentTheme == ThemeMode.dark,
                          onChanged: (value) {
                            themeController.toggleTheme();
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Material(
                      elevation: 5.0,
                      shadowColor: Theme.of(context).colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: Text('settings_screen.language'.tr()),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                title: Center(
                                  child: Text(
                                      'settings_screen.select_language'.tr()),
                                ),
                                alignment: Alignment.center,
                                titlePadding: const EdgeInsets.all(20),
                                contentPadding: const EdgeInsets.all(20),
                                children: [
                                  ListTile(
                                    leading: Image.network(
                                        'https://flagsapi.com/VN/flat/64.png'),
                                    title: const Text('Tiếng Việt'),
                                    onTap: () {
                                      themeController.setLocale(
                                        context: context,
                                        locale: const Locale('vi', 'VN'),
                                      );
                                      Navigator.pop(context);
                                    },
                                    trailing: context.locale ==
                                            const Locale('vi', 'VN')
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                                  ),
                                  ListTile(
                                    leading: Image.network(
                                        'https://flagsapi.com/US/flat/64.png'),
                                    title: const Text('English'),
                                    onTap: () {
                                      themeController.setLocale(
                                        context: context,
                                        locale: const Locale('en', 'US'),
                                      );
                                      Navigator.pop(context);
                                    },
                                    trailing: context.locale ==
                                            const Locale('en', 'US')
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          )
                                        : null,
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        leading: const Icon(Icons.translate),
                        trailing: Text(
                          context.locale.languageCode.toUpperCase(),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
