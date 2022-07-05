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
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isSending = false;

  Future<bool> _getMultilineAllowed() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(multilinePrefKey) ?? multilineDefaultValue;
  }

  /// Clear text, disallow sending until finished
  Future _sendMessage() async {
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
            final multilineAllowed = snapshot.data as bool;
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
