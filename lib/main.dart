import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:masque/firebase_options.dart';
import 'package:masque/src/data/shared_objects.dart';
import 'package:masque/src/screens/tab_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final sharedObjects = SharedObjects();
  await sharedObjects.setDefaultsIfNull();

  runApp(
    Provider.value(
      value: sharedObjects,
      child: const Masque(),
    ),
  );
}

/// The main client.
class Masque extends StatelessWidget {
  /// Create a new [Masque] instance.
  const Masque({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Masque',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
      ),
      home: const TabScreen(),
    );
  }
}
