import 'package:flutter/material.dart';
import 'home_page.dart';
import 'settings_page.dart';
import 'app_setting.dart';

class MainAppPage extends StatefulWidget {
  const MainAppPage({super.key});

  @override
  _MainAppPageState createState() => _MainAppPageState();
}

class _MainAppPageState extends State<MainAppPage> {
  int currentIndex = 0;

  final List<Widget> screens = [
    const HomePage(),
    const SettingsPage(),       // Profile
    const AppSettingsPage(),    // App Settings
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon:Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
} 