import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/widgets/message_widget.dart';
import 'package:provider/provider.dart';

/// A live feed of the messages flowing.
class ChatLogWidget extends StatefulWidget {
  /// Create a new [ChatLogWidget].
  const ChatLogWidget({super.key});

  @override
  State<ChatLogWidget> createState() => _ChatLogWidgetState();
}

class _ChatLogWidgetState extends State<ChatLogWidget> {
  late final _database = context.read<Database>();

  MessageModel _mapToMessage(Map<String, dynamic> data) {
    return MessageModel(
      timeInMillis: data['timestamp'] as int,
      screenName: data['screenName'] as String,
      content: data['content'] as String,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _database.getMessageStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.map((e) {
            final data = e.data()! as Map<String, dynamic>;
            return _mapToMessage(data);
          }).toList();

          return Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) => MessageWidget(messages[index]),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
