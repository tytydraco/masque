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
  final messageController = TextEditingController();
  var isSending = false;

  /// Clear text, disallow sending until finished
  Future _sendMessage() async {
    final text = messageController.text;
    messageController.clear();
    setState(() => isSending = true);
    await widget.onSend(text);
    setState(() => isSending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        autofocus: true,
        controller: messageController,
        maxLines: null,
        decoration: InputDecoration(
          hintText: 'Message',
          suffixIcon: IconButton(
            onPressed: !isSending ? _sendMessage : null,
            icon: const Icon(Icons.send),
          ),
        ),
        onSubmitted: (_) => !isSending ? _sendMessage() : null,
        onEditingComplete: () {},
        textInputAction: TextInputAction.send,
      ),
    );
  }
}
