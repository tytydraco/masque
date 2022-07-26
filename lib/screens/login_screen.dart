import 'package:flutter/material.dart';
import 'package:masque/models/session_model.dart';
import 'package:masque/screens/chat_screen.dart';
import 'package:masque/widgets/custom_login_widget.dart';
import 'package:provider/provider.dart';

/// The main login screen.
class LoginScreen extends StatefulWidget {
  /// Create a new [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _enterChat(SessionModel session) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => Provider.value(
          value: session,
          child: const ChatScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomLoginWidget(
          onSubmit: _enterChat,
        ),
      ),
    );
  }
}
