import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:masque/models/message_model.dart';

class MessageWidget extends StatelessWidget {
  final MessageModel message;

  const MessageWidget({
    Key? key,
    required this.message,
  }) : super(key: key);

  void onTapLink(String text, String? href, String title) {
    if (href != null) {
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final date = DateTime.fromMillisecondsSinceEpoch(message.timeInMillis);
    final prettyDate = DateFormat.yMd().add_jm().format(date);

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
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
            ),
            MarkdownBody(
              selectable: true,
              data: message.content,
              onTapLink: onTapLink,
            ),
          ],
        ),
      ),
    );
  }
}
