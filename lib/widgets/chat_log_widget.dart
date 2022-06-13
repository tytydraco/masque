import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/widgets/message_widget.dart';

class ChatLogWidget extends StatefulWidget {
  final String roomId;

  const ChatLogWidget({
    Key? key,
    required this.roomId,
  }) : super(key: key);

  @override
  State<ChatLogWidget> createState() => _ChatLogWidgetState();
}

class _ChatLogWidgetState extends State<ChatLogWidget> {
  late final Database database;

  MessageModel mapToMessage(Map<String, dynamic> data) {
    return MessageModel(
      timeInMillis: data['timestamp'],
      screenName: data['screenName'],
      content: data['content'],
    );
  }

  @override
  void initState() {
    database = Database(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.getMessageStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data!.docs.map((e) {
            final data = e.data()! as Map<String, dynamic>;
            return mapToMessage(data);
          }).toList();

          return Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => MessageWidget(message: messages[index]),
            ),
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else {
          return const CircularProgressIndicator();
        }
      }
    );
  }
}
