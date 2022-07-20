import 'package:flutter/material.dart';
import 'package:masque/screens/chat_screen.dart';
import 'package:masque/widgets/custom_login_widget.dart';

/// The main login screen.
class LoginScreen extends StatefulWidget {
  /// Create a new [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _enterChat(String screenName, String roomId) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ChatScreen(
          screenName: screenName,
          roomId: roomId,
        ),
      ),
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
