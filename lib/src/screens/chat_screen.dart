import 'package:flutter/material.dart';
import 'package:masque/src/models/message_model.dart';
import 'package:masque/src/models/session_model.dart';
import 'package:masque/src/remote/database.dart';
import 'package:masque/src/widgets/chat_bar_widget.dart';
import 'package:masque/src/widgets/chat_log_widget.dart';
import 'package:provider/provider.dart';

/// Screen to send and receive messages.
class ChatScreen extends StatefulWidget {
  /// Create a new [ChatScreen].
  const ChatScreen({
    super.key,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final _session = context.read<SessionModel>();
  late final _database = Database(_session.roomId);

  Future<void> _sendMessage(String text) async {
    final message =
        MessageModel.now(screenName: _session.screenName, content: text);
    await _database.sendMessage(message);
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(
      value: _database,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const ChatLogWidget(),
              ChatBarWidget(onSend: _sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}
