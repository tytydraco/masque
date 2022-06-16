import 'package:flutter/material.dart';
import 'package:masque/screens/login_screen.dart';
import 'package:masque/screens/settings_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var currentTabIndex = 0;

  final bottomNavWidgets = const [
    LoginScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final platform = Theme.of(context).platform;
    final isMobile =
        (platform == TargetPlatform.android ||
        platform == TargetPlatform.iOS ||
        platform == TargetPlatform.fuchsia);

    return Scaffold(
      body: Center(
        child: bottomNavWidgets[currentTabIndex]
      ),
      appBar: isMobile ? AppBar(
        title: const Text('Masque'),
      ) : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentTabIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() => currentTabIndex = index);
        },
      ),
    );
  }
}
