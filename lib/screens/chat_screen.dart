import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/widgets/chat_bar_widget.dart';
import 'package:masque/widgets/chat_log_widget.dart';

class ChatScreen extends StatefulWidget {
  final String screenName;
  final String roomId;

  const ChatScreen({
    Key? key,
    required this.screenName,
    required this.roomId
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final database = Database(widget.roomId);

  @override
  Widget build(BuildContext context) {
    Future sendMessage(String text) async {
      final message = MessageModel.now(
        screenName: widget.screenName,
        content: text
      );
      await database.sendMessage(message);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ChatLogWidget(roomId: widget.roomId),
            ChatBarWidget(onSend: sendMessage),
          ],
        ),
      ),
    );
  }
}
