import 'package:flutter/material.dart';
import 'package:masque/src/data/pref_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An interactive chat input box.
class ChatBarWidget extends StatefulWidget {
  /// Create a new [ChatBarWidget] given an [onSend] callback.
  const ChatBarWidget({
    super.key,
    required this.onSend,
  });

  /// A callback given a [String] for when the user submits a message.
  final Future<void> Function(String) onSend;

  @override
  State<ChatBarWidget> createState() => _ChatBarWidgetState();
}

class _ChatBarWidgetState extends State<ChatBarWidget> {
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  Future<bool> _getMultilineAllowed() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(multilinePrefKey) ?? false;
  }

  /// Clear text, disallow sending until finished
  Future<void> _sendMessage() async {
    if (_formKey.currentState!.validate()) {
      final text = _messageController.text;
      _messageController.clear();
      setState(() => _isSending = true);
      await widget.onSend(text);
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FutureBuilder(
        future: _getMultilineAllowed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final multilineAllowed = snapshot.data! as bool;
            return Form(
              key: _formKey,
              child: TextFormField(
                autofocus: true,
                controller: _messageController,
                maxLines: multilineAllowed ? null : 1,
                decoration: InputDecoration(
                  hintText: 'Message',
                  suffixIcon: IconButton(
                    onPressed: !_isSending ? _sendMessage : null,
                    icon: const Icon(Icons.send),
                  ),
                ),
                onFieldSubmitted: (_) => !_isSending ? _sendMessage() : null,
                onEditingComplete: () {},
                textInputAction: multilineAllowed
                    ? TextInputAction.newline
                    : TextInputAction.send,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Required';
                  } else if (input.length > 2000) {
                    return 'Too long';
                  }
                  return null;
                },
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
