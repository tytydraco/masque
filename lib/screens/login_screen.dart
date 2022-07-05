import 'package:flutter/material.dart';
import 'package:masque/screens/chat_screen.dart';
import 'package:masque/widgets/custom_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _enterChat(String screenName, String roomId) {
    Navigator
        .of(context)
        .push(
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              screenName: screenName,
              roomId: roomId,
            )
          )
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomLoginWidget(
          onLogin: _enterChat,
        ),
      ),
    );
  }
}