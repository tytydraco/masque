import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(message.timeInMillis);
    final prettyDate = date.toIso8601String();

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${message.screenName}, $prettyDate'),
          Text(message.content),
        ],
      ),
    );
  }
}
