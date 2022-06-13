import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
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
  late final Database database;

  @override
  void initState() {
    database = Database(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final messageFocusNode = FocusNode();
    final messageController = TextEditingController();

    Future sendMessage() async {
      final text = messageController.text;
      messageController.text = '';
      messageFocusNode.requestFocus();
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
            Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                focusNode: messageFocusNode,
                autofocus: true,
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Message',
                  suffixIcon: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ),
                onSubmitted: (_) => sendMessage(),
                textInputAction: TextInputAction.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
