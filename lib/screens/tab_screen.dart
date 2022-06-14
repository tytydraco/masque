import 'package:flutter/material.dart';
import 'package:masque/screens/login_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  var currentTabIndex = 0;

  final bottomNavWidgets = const [
    LoginScreen(),
    Text('to do'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: bottomNavWidgets[currentTabIndex]
      ),
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
