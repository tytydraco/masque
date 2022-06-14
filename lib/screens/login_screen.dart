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
  final formKey = GlobalKey<FormState>();

  void enterChat() {
    if (formKey.currentState!.validate()) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Must have a screen name';
                      } else {
                        return null;
                      }
                    },
                    controller: screenNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Screen name'
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Invalid room id';
                      } else {
                        return null;
                      }
                    },
                    controller: roomIdController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Room id'
                    ),
                    onFieldSubmitted: (_) => enterChat(),
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
          ),
        ),
      ),
    );
  }
}