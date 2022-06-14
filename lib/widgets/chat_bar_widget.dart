import 'package:flutter/material.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<bool> getMultilineAllowed() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(multilinePrefKey) ?? multilineDefaultValue;
  }

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
    return FutureBuilder(
      initialData: multilineDefaultValue,
      future: getMultilineAllowed(),
      builder: (context, snapshot) {
        final multilineAllowed = snapshot.data as bool;
        return Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
            autofocus: true,
            controller: messageController,
            maxLines: multilineAllowed ? null : 1,
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
      },
    );
  }
}
