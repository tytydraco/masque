import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/widgets/message_widget.dart';

class ChatLogWidget extends StatefulWidget {
  final List<MessageModel> messages;

  const ChatLogWidget({
    Key? key,
    required this.messages,
  }) : super(key: key);

  @override
  State<ChatLogWidget> createState() => _ChatLogWidgetState();
}

class _ChatLogWidgetState extends State<ChatLogWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.messages.length,
      itemBuilder: (context, index) {
        final message = widget.messages[index];
        return MessageWidget(message: message);
      },
    );
  }
}
