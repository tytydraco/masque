import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/widgets/chat_bar_widget.dart';
import 'package:masque/widgets/chat_log_widget.dart';

/// Screen to send and receive messages given a [screenName] and a [roomId].
class ChatScreen extends StatefulWidget {
  /// Create a new [ChatScreen] given a [screenName] and a [roomId].
  const ChatScreen({
    super.key,
    required this.screenName,
    required this.roomId,
  });

  /// The user's display name.
  final String screenName;

  /// The referenced room id.
  final String roomId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final _database = Database(widget.roomId);

  @override
  Widget build(BuildContext context) {
    Future<void> sendMessage(String text) async {
      final message =
          MessageModel.now(screenName: widget.screenName, content: text);
      await _database.sendMessage(message);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ChatLogWidget(roomId: widget.roomId),
            ChatBarWidget(onSend: sendMessage),
          ],
        ),
      ),
    );
  }
}
