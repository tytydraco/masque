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
  var isSending = false;

  Future _sendMessage() async {
    setState(() => isSending = true);
    await widget.onSend(messageController.text);
    setState(() => isSending = false);
    messageController.text = '';
    messageFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        readOnly: isSending,
        focusNode: messageFocusNode,
        autofocus: true,
        controller: messageController,
        decoration: InputDecoration(
          hintText: 'Message',
          suffixIcon: IconButton(
            onPressed: !isSending ? _sendMessage : null,
            icon: const Icon(Icons.send),
          ),
        ),
        onSubmitted: (_) => !isSending ? _sendMessage() : null,
        textInputAction: TextInputAction.send,
      ),
    );
  }
}
