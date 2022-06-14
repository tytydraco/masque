import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    final prettyDate = DateFormat.yMd().add_jm().format(date);

    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  message.screenName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(prettyDate),
            ],
          ),
          Text(message.content),
        ],
      ),
    );
  }
}
