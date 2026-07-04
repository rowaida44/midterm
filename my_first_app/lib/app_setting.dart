import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'provide.dart';

class AppSettingsPage extends StatefulWidget {
  const AppSettingsPage({super.key});

  @override
  _AppSettingsPageState createState() => _AppSettingsPageState();
}

class _AppSettingsPageState extends State<AppSettingsPage> {
  bool dailyReminder = false;
  bool studyReminder = false;

  @override
  Widget build(BuildContext context) {
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    String language = context.locale.languageCode == 'ar'
        ? 'Arabic'
        : 'English';

    return Scaffold(
      appBar: AppBar(
        title: Text("app_settings".tr()),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    shape: BoxShape.circle,
                  ),
                ),
                const Icon(Icons.edit, size: 60, color: Colors.blue),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Text(
            "preferences".tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text("language".tr()),
            trailing: DropdownButton<String>(
              value: language,
              items: const [
                DropdownMenuItem(
                  value: 'English',
                  child: Text('English'),
                ),
                DropdownMenuItem(
                  value: 'Arabic',
                  child: Text('Arabic'),
                ),
              ],
              onChanged: (val) {
                if (val == 'Arabic') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              },
            ),
          ),

          SwitchListTile(
            secondary: const Icon(Icons.alarm),
            title: Text("daily_reminder".tr()),
            value: dailyReminder,
            onChanged: (val) {
              setState(() {
                dailyReminder = val;
              });
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: Text("dark_mode".tr()),
            value: themeProvider.isDarkMode,
            onChanged: (val) {
              themeProvider.toggleTheme(val);
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.book),
            title: Text("study_reminder".tr()),
            value: studyReminder,
            onChanged: (val) {
              setState(() {
                studyReminder = val;
              });
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.sync),
            title: Text("sync_data".tr()),
            value: true,
            onChanged: (val) {},
          ),

          const SizedBox(height: 20),

          Text(
            "other".tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          ListTile(
            leading: const Icon(Icons.description),
            title: Text("terms".tr()),
            onTap: () {},
          ),

          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text("privacy".tr()),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}