import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masque/firebase_options.dart';
import 'package:masque/screens/login_screen.dart';
import 'package:masque/screens/tab_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masque',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TabScreen(),
    );
  }
}
