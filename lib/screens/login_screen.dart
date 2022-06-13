import 'package:flutter/material.dart';
import 'package:masque/screens/chat_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final screenNameController = TextEditingController();
  final roomIdController = TextEditingController();

  void enterChat() {
    Navigator
        .of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              screenName: screenNameController.text,
              roomId: roomIdController.text,
            )
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              controller: screenNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Screen name'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: TextField(
              controller: roomIdController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Room id'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: ElevatedButton(
              onPressed: enterChat,
              child: const Text('Enter'),
            ),
          )
        ],
      ),
    );
  }
}