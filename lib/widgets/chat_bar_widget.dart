import 'package:flutter/material.dart';

class ChatBarWidget extends StatefulWidget {
  final Future Function(String) onSend;

  const ChatBarWidget({
    Key? key,
    required this.onSend
  }) : super(key: key);

  @override
  State<ChatBarWidget> createState() => _ChatBarWidgetState();
}

class _ChatBarWidgetState extends State<ChatBarWidget> {
  final messageFocusNode = FocusNode();
  final messageController = TextEditingController();

  Future _sendMessage() async {
    final text = messageController.text;
    messageController.text = '';
    messageFocusNode.requestFocus();
    await widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        focusNode: messageFocusNode,
        autofocus: true,
        controller: messageController,
        decoration: InputDecoration(
          hintText: 'Message',
          suffixIcon: IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ),
        onSubmitted: (_) => _sendMessage(),
        textInputAction: TextInputAction.send,
      ),
    );
  }
}
