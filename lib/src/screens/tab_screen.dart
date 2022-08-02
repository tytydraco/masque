import 'package:flutter/material.dart';
import 'package:masque/src/screens/login_screen.dart';
import 'package:masque/src/screens/settings_screen.dart';

/// Screen to hold the main menu screens.
class TabScreen extends StatefulWidget {
  /// Create a new [TabScreen].
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var _currentTabIndex = 0;

  final _bottomNavWidgets = const [
    LoginScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final _platform = Theme.of(context).platform;
    final _isMobile = _platform == TargetPlatform.android ||
        _platform == TargetPlatform.iOS ||
        _platform == TargetPlatform.fuchsia;

    return Scaffold(
      body: Center(child: _bottomNavWidgets[_currentTabIndex]),
      appBar: _isMobile
          ? AppBar(
              title: const Text('Masque'),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTabIndex,
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
          setState(() => _currentTabIndex = index);
        },
      ),
    );
  }
}
